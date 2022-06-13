//
//  ChosePlaylistSheet.swift
//  SongApp
//
//  Created by Давид Лисицын on 13.06.2022.
//

import SwiftUI

struct ChosePlaylistSheet: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(fetchRequest: Playlist.getAll()) var playlists : FetchedResults<Playlist>
    
    @State var chosen: String = ""
    @State var song : SP
    
    var body: some View {
        VStack{
            HStack {
                Spacer()
                Button(action: { presentationMode.wrappedValue.dismiss() }, label: {Text("Отменить")}).padding()
            }
            Spacer()
            if let song = song {
                Text("\(song.getname())").font(.headline)
            }
            Spacer()
            Text("Добавить в плейлист").font(.footnote).foregroundColor(.gray)
            List(playlists, id: \.self.id) { playlist in
                Button(action: {
                    print("Принять \(chosen) песня \(song.getname())")
                    song.saveToList(name: playlist.unwrapName, context: viewContext)
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    PlaylistLineView(playlistname: playlist.unwrapName, playlistsongs: playlist.unwrapSongs.count)
                }).colorMultiply(.black)
            }
            Spacer()
        }
    }
}

//struct ChosePlaylistSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        ChosePlaylistSheet()
//    }
//}
