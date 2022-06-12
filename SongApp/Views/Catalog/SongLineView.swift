//
//  SongLineView.swift
//  SongApp
//
//  Created by Давид Лисицын on 08.06.2022.
//

import SwiftUI

struct SongLineView: View {
    @Environment(\.managedObjectContext) private var viewContext
    //@FetchRequest(fetchRequest: Song.getAll()) private var songs: FetchedResults<Song>
    
    var song : SP
    
    var body: some View {
        HStack {
            Image(systemName: "music.note")
                //.resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(5)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            VStack(alignment: .leading) {
                HStack {
                    Text("Название:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(song.getname())
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer().frame(height: 10)
                HStack {
                    Text("Автор:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(song.getauthor()).font(.system(size: 13))
                }
            }
            Spacer()
            if(song.isSaveInFavoriteList(context: viewContext)) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }.padding(5)
    }
}

//struct SongLine_Previews: PreviewProvider {
//    static var previews: some View {
//        SongLine()
//    }
//}
