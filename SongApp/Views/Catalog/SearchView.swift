//
//  SearchView.swift
//  SongApp
//
//  Created by Давид Лисицын on 08.06.2022.
//

import SwiftUI

struct SearchView: View {
    @State private var search: String = ""
    @FocusState private var FieldIsFocused: Bool
    @State var filterIsVisible : Bool = false
    
    @ObservedObject var songsViewModel : SongsService
    @ObservedObject var filter : Filter
    
    var body: some View {
        VStack{
            ZStack {
                Rectangle()
                    .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.8941176470588236, green: 0.9137254901960784, blue: 0.9529411764705882)/*@END_MENU_TOKEN@*/)
                    .cornerRadius(9)
                // Вывод надписи при пустом неативном поле
                if !FieldIsFocused && search == ""{
                    Text("Поиск").foregroundColor(.black)
                }
                HStack {
                    if search == "" {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                    }
                    TextField("",text: $search)
                        .foregroundColor(.black)
                        .keyboardType(.webSearch)
                        .focused($FieldIsFocused)
                        .onSubmit {
                            print("Submit! \(search)")
                            if(search != ""){
                                songsViewModel.search(searchstr: search, searchby: filter.search, sortby: filter.sort, inverse: filter.inverse, onlyby: filter.only)
                            } else {
                                songsViewModel.getAll(sortby: filter.sort, inverse: filter.inverse, onlyby: filter.only)
                            }
                        }
                    if search != "" {
                        Button(action: { search = "" }) {
                            Image(systemName: "xmark.circle.fill").foregroundColor(.black)
                        }
                    }
                    // Кнопка открытие фильтра
                    Button(action: {
                        filterIsVisible.toggle()
                    }) {
                        Image(systemName: "text.justify")
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 5.0)
                }
                .padding()
            }
            .frame(height: 38)
            .padding()
            if(filterIsVisible) {
                ZStack {
                    Rectangle()
                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.8941176470588236, green: 0.9137254901960784, blue: 0.9529411764705882)/*@END_MENU_TOKEN@*/)
                        .cornerRadius(9)
                    VStack{
                        HStack{
                            Text("Only")
                            Spacer()
                            Picker("Only by", selection: $filter.only) {
                                ForEach(Onlyby.allCases, id: \.self) { only in
                                    Text(only.rawValue)
                                }
                            }.onChange(of: filter.only) { value in
                                print("change only by to \(value) НЕ РАБОТАЕТ ПОКА")
                                songsViewModel.getAll(sortby: filter.sort, inverse: filter.inverse, onlyby: filter.only)
                            }
                        }.padding()
                        HStack{
                            Text("Search by")
                            Spacer()
                            Picker("Search by", selection: $filter.search) {
                                ForEach(Searchby.allCases, id: \.self) { search in
                                    Text(search.rawValue)
                                }
                            }.onChange(of: filter.search) { value in
                                print("change search by to \(value)")
                                songsViewModel.getAll(sortby: filter.sort, inverse: filter.inverse, onlyby: filter.only)
                            }
                        }.padding()
                        HStack{
                            Text("Sort by")
                            Spacer()
                            Picker("Sort by", selection: $filter.sort) {
                                ForEach(Sortby.allCases, id: \.self){ sort in
                                    Text(sort.rawValue)
                                }
                            }.onChange(of: filter.sort) { value in
                                print("change sort by to \(value)")
                                songsViewModel.getAll(sortby: filter.sort, inverse: filter.inverse, onlyby: filter.only)
                            }
                        }.padding()
                        Toggle("Inverse", isOn: $filter.inverse)
                            .padding()
                            .onChange(of: filter.inverse) { value in
                                print("change inverse by to \(value)")
                                songsViewModel.getAll(sortby: filter.sort, inverse: filter.inverse, onlyby: filter.only)
                            }
                    }
                }
                .frame(height: 220)
                .padding()
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    
    @ObservedObject static var songsViewModel : SongsService = SongsService(.all)
    @ObservedObject static var filter: Filter = Filter()
    
    static var previews: some View {
        SearchView(songsViewModel: songsViewModel, filter: filter)
    }
}
