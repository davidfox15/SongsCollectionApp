//
//  Filter.swift
//  SongApp
//
//  Created by Давид Лисицын on 08.06.2022.
//

import Foundation

class Filter: ObservableObject{
    @Published var search: Searchby
    @Published var sort: Sortby
    @Published var only: Onlyby
    @Published var inverse: Bool
    
    init() {
        search = Searchby.name
        sort = Sortby.name
        only = Onlyby.all
        inverse = false
    }
    
    func sort(songs: [Song]) -> [Song] {
        let newSongs: [Song]
        switch(self.sort){
        case .name:
            newSongs = songs.sorted(by: {
                if(inverse){
                    return $0.name < $1.name
                } else {
                    return $0.name > $1.name
                }
            })
        case .author:
            newSongs = songs.sorted(by: {
                if(inverse){
                    return $0.author < $1.author
                } else {
                    return $0.author > $1.author
                }
            })
        case .views:
            newSongs = songs.sorted(by: {
                if(inverse){
                    return $0.views > $1.views
                } else {
                    return $0.views < $1.views
                }
            })
        }
        return newSongs
    }
    
    func search(songs: [Song], searchString: String) -> [Song] {
        var newSongs: [Song] = []
        for song in songs {
            switch(self.search){
            case .name:
                if(song.name.lowercased().contains(searchString.lowercased())) {
                    newSongs.append(song)
                }
            case .author:
                if(song.author.lowercased().contains(searchString.lowercased())) {
                    newSongs.append(song)
                }
            case .text:
                if(song.text.lowercased().contains(searchString.lowercased())) {
                    newSongs.append(song)
                }
            }
        }
        return newSongs
    }
    
}

enum Searchby : String, CaseIterable, Identifiable  {
    case name
    case author
    case text
    var id: Searchby { self }
}

enum Sortby : String, CaseIterable, Identifiable {
    case name
    case author
    case views
    var id: Sortby { self }
}

enum Onlyby : String, CaseIterable, Identifiable {
    case all
    case russian
//    case christian
    case english
    var id: Onlyby { self }
}
