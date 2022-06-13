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
    
    var body: some View {
        NavigationView {
            VStack {
                // Поисковая строка
                SearchView(songsViewModel: songsViewModel, filter: filter)
                if(songsViewModel.connect == false){
                    Text("could not connect to the server")
                }
                // Список песен
                NavigationLink(destination: SongsListView(playlist: Playlist.getFavoriteList(context: viewContext)), label: {Text("Favorite")})

                Button(action: {
//                    for song in songs {
//                        viewContext.delete(song)
//                    }
//                    if viewContext.hasChanges {
//                        print("delted")
//                        try? viewContext.save()
//                    }
                }, label: {Text("DELETE")})
                
                List(songsViewModel.songs, id: \.self.id) { song in
                    // Переход на страницу с песней
                    NavigationLink(destination: SongView(song: song)) {
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
                                songsViewModel.getAll(sortby: filter.sort, inverse: filter.inverse)
                            }
                        } label: {
                            Label("Favorite", systemImage: "star")
                        }
                        .tint(.yellow)
                        Button(role: .destructive) {
                            print("add to playlist")
                            showSheet.toggle()
                        } label: {
                            Label("Playlist", systemImage: "plus.circle")
                        }
                        .tint(.blue)
                    }
                    //                    .sheet(isPresented: $showSheet) {
                    //                        ChosePlaylistSheet(song: song)
                    //                    }
                }
                .listStyle(.plain)
                .navigationBarHidden(true)
                .refreshable {
                    songsViewModel.getAll(sortby: filter.sort, inverse: filter.inverse)
                }
                NavigationBarView(page: $page)
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
