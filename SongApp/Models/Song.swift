//
//  Song_unmanaged.swift
//  SongApp
//
//  Created by Давид Лисицын on 08.06.2022.
//

import Foundation
import CoreData
import SwiftUI

class Song: Codable, SP {

    public var name: String
    public var author: String
    public var text: String
    public var id: Int32
    public var views: Int32
    
    public func converToSong(context: NSManagedObjectContext) -> CDSong {
        let song = CDSong(context: context)
        song.name = name
        song.author = author
        song.text = text
        song.views = views
        song.id = id
        return song
    }
    
    func getname() -> String {
        return name
    }
    
    func getauthor() -> String {
        return author
    }
    
    func gettext() -> String {
        return text
    }
    
    func getviews() -> Int32 {
        return views
    }
    
    func getid() -> Int32 {
        return id
    }
    
    func isSaveInFavoriteList(context: NSManagedObjectContext) -> Bool {
        // Ищет избранное елси оно уже созданно, создает если его нет
        let favorite = Playlist.getFavoriteList(context: context)
        // Ищет в избранном песню
        for song in favorite.unwrapSongs {
            if(self.id == song.id) {
                return true
            }
        }
        return false
    }
    
    func saveToFavorite(context: NSManagedObjectContext) {
        // Проверка на наличие песни в избранном
        if(!self.isSaveInFavoriteList(context: context)) {
            let favorite = Playlist.getFavoriteList(context: context)
            favorite.addToSongs(self.converToSong(context: context))
            if(context.hasChanges) {
                try? context.save()
            }
        }
    }
//    public func isSave(songs: FetchedResults<CDSong>)-> Bool {
//        for song in songs {
//            if(song.id == self.id) {
//                return true
//            }
//        }
//        return false
//    }
}
