//
//  CatalogView.swift
//  SongApp
//
//  Created by Давид Лисицын on 08.06.2022.
//

import SwiftUI

struct CatalogView: View {
    @Environment(\.managedObjectContext) private var viewContext
    //@FetchRequest(fetchRequest: Song.getAll()) private var songs: FetchedResults<Song>
    
    // Смена страницы
    @Binding var page: Int
    // Загруженные песни
    @ObservedObject var songsViewModel : SongsService
    // Фильтр
    @ObservedObject var filter : Filter
    
    @State var showSheet : Bool = false
    
    @State private var chosesong : Song? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                // Поисковая строка
                SearchView(songsViewModel: songsViewModel, filter: filter)
                if(songsViewModel.connect == false){
                    Text("could not connect to the server")
                }
                
                // Костыль для работы sheet с первого рза (ОРУ) != nil
                if chosesong != nil {}
                
                // Список песен
                List(songsViewModel.songs, id: \.self.id) { song in
                    // Переход на страницу с песней
                    NavigationLink(destination: SongView(song: song,text: song.gettext())) {
                        // Строка с песней
                        SongLineView(song:  song)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            if(song.isSaveInFavoriteList(context: viewContext)) {
                                // delete from favorite
                            } else {
                                // add to favorite
                                song.saveToFavorite(context: viewContext)
                                // для обновления звездочки
                                songsViewModel.getAll(sortby: filter.sort, inverse: filter.inverse, onlyby: filter.only)
                            }
                        } label: {
                            //Favorite
                            Label("", systemImage: "star")
                        }
                        .tint(.yellow)
                        Button(role: .destructive) {
                            self.chosesong = Song(song)
                            showSheet.toggle()
                        } label: {
                            //Playlist
                            Label("", systemImage: "plus.circle")
                        }
                        .tint(.blue)
                    }
                }
                .listStyle(.plain)
                .navigationBarHidden(true)
                .refreshable {
                    songsViewModel.getAll(sortby: filter.sort, inverse: filter.inverse, onlyby: filter.only)
                }
                NavigationBarView(page: $page)
            }
            .sheet(isPresented: $showSheet, onDismiss: {
                songsViewModel.getAll(sortby: filter.sort, inverse: filter.inverse, onlyby: filter.only)
            }) {
                if let chosesong = self.chosesong {
                    ChosePlaylistSheet(song: chosesong)
                } else {
                    Text("chosesong is nil")
                }
            }
            .frame(maxHeight: .infinity ,alignment: .bottom)
            .ignoresSafeArea(.container, edges: .bottom)
        }
        .accentColor(/*@START_MENU_TOKEN@*/Color(red: 0.18823529411764706, green: 0.26666666666666666, blue: 0.3058823529411765)/*@END_MENU_TOKEN@*/)
    }
}

struct CatalogView_Previews: PreviewProvider {
    @State static var page: Int = 1
    static var previews: some View {
        CatalogView(page: $page, songsViewModel: SongsService(.all), filter: Filter())
    }
}
