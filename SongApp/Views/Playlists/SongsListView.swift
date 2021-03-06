//
//  SongsListView.swift
//  SongApp
//
//  Created by Давид Лисицын on 08.06.2022.
//

import SwiftUI

struct SongsListView: View {
    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(fetchRequest: Song.getAll())private var songs : FetchedResults<Song>
    @ObservedObject var playlist : Playlist
    
    @State var showSheet : Bool = false
    
    var body: some View {
        VStack {
            // Список песен
            List(playlist.unwrapSongs, id: \.self.id) { song in
                // Переход на страницу с песней
                NavigationLink(destination: SongView(song: song,text: song.gettext())) {
                    // Строка с песней
                    SaveSongLineView(song: song)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        print("delete")
                        viewContext.delete(song)
                        if(viewContext.hasChanges) {
                            try? viewContext.save()
                        }
                    } label: {
                        Label("", systemImage: "trash")
                    }
                    .tint(.red)
//                    Button(role: .destructive) {
//                        print("add to playlist")
//                        showSheet.toggle()
//                    } label: {
//                        Label("", systemImage: "plus.circle")
//                    }
//                    .tint(.blue)
                }
//                .sheet(isPresented: $showSheet) {
//                    ChosePlaylistSheet(song: song)
//                }
            }
            //.listStyle(.plain)
            //.navigationBarHidden(true)
            .navigationBarTitle(playlist.unwrapName, displayMode: .inline)
        }
        .frame(maxHeight: .infinity ,alignment: .bottom)
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

//struct SongsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SongsListView()
//    }
//}
