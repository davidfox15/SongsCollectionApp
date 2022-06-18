//
//  PlaylistLineView.swift
//  SongApp
//
//  Created by Давид Лисицын on 13.06.2022.
//

import SwiftUI

struct PlaylistLineView: View {
    var playlistname: String
    var playlistsongs: Int
    var body: some View {
        HStack {
            Image(systemName: "text.append")
                .frame(width: 30, height: 30)
                .cornerRadius(5)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            VStack(alignment: .leading) {
                HStack(alignment: .bottom){
                    if(playlistname == "Favorite"){
                        Text("Избранное")
                            .font(.system(size: 30, weight: .bold))
                    }else{
                    Text("\(playlistname)")
                            .font(.system(size: 30, weight: .bold))
                    }
                        
                    Text("Кол-во песен: \(playlistsongs)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
        }
        .padding()
    }
}


struct PlaylistLineView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistLineView(playlistname: "Test", playlistsongs: 30)
    }
}
