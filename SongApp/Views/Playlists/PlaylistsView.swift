//
//  PlaylistsView.swift
//  SongApp
//
//  Created by Давид Лисицын on 13.06.2022.
//

import SwiftUI

struct PlaylistsView: View {
    @Binding var page: Int
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Playlist.getAll()) var playlists : FetchedResults<Playlist>
    
    @State var playlistName : String = ""
    
    var body: some View {
        NavigationView {
            VStack{                
                // Плейлисты
                List(playlists, id: \.self.id) { item in
                    NavigationLink(destination: SongsListView(playlist: item)) {
                        // Строка с песней
                        PlaylistLineView(playlistname: item.unwrapName, playlistsongs: item.unwrapSongs.count)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            print("delete")
                            viewContext.delete(item)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
                    }
                }
                .navigationBarTitle("Playlists")
                .listStyle(.inset)
                
                
                //Строка для добавления плейлистов
                Text("Create Playlist")
                ZStack {
                    Rectangle()
                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.8941176470588236, green: 0.9137254901960784, blue: 0.9529411764705882)/*@END_MENU_TOKEN@*/)
                        .cornerRadius(9)
                    HStack {
                        TextField("",text: $playlistName)
                            .foregroundColor(.black)
                            .keyboardType(.webSearch)
                            .onSubmit {
                                if(playlistName != ""){
                                    //CoreDataService.createPlaylist(songsFromDB: playlists, viewContext: viewContext , name: playlistName)
                                    
                                } else {
                                    print("Not create empty name playlist")
                                }
                            }
                        Button(action: {
                            if(playlistName != ""){
                                //CoreDataService.createPlaylist(songsFromDB: playlists, viewContext: viewContext , name: playlistName)
                            } else {
                                print("Not create empty name playlist")
                            }
                        }, label: {Image(systemName: "plus.circle").foregroundColor(.black)})
                    }
                    .padding()
                }
                .frame(height: 38)
                .padding()
                
                
                //Меню
                NavigationBarView(page: $page)
            }
            .frame(maxHeight: .infinity ,alignment: .bottom)
            .ignoresSafeArea(.container, edges: .bottom)
        }
    }
}


struct PlaylistsView_Previews: PreviewProvider {
    @State static var page: Int = 3
    static var previews: some View {
        PlaylistsView(page: $page)
    }
}
