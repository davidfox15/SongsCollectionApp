//
//  CDSong+CoreDataClass.swift
//  SongApp
//
//  Created by Давид Лисицын on 12.06.2022.
//
//

import Foundation
import CoreData

@objc(CDSong)
public class CDSong: NSManagedObject, SP {

    public var unwrapName : String {
        name ?? "Unknow Song"
    }
    
    public var unwrapAuthor : String {
        author ?? "Unknow Author"
    }
    
    public var unwrapText : String {
        text ?? "Unknow Author"
    }
    
    public var unwrapPlaylists : [Playlist] {
        if playlists != nil{
            return playlists!.toArray()
        } else {
            return []
        }
    }
    
    static func getAll() -> NSFetchRequest<CDSong> {
        let request : NSFetchRequest<CDSong> = CDSong.fetchRequest()
        let sortDescriptor: NSSortDescriptor = NSSortDescriptor(keyPath: \CDSong.name, ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }
    
    func getname() -> String {
        return unwrapName
    }
    
    func getauthor() -> String {
        return unwrapAuthor
    }
    
    func gettext() -> String {
        return unwrapText
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
            favorite.addToSongs(self)
            if(context.hasChanges) {
                try? context.save()
            }
        }
    }
    
    func isSaveInList(name: String, context: NSManagedObjectContext) -> Bool {
        // Ищет избранное елси оно уже созданно, создает если его нет
        if let list = Playlist.getList(name: name, context: context ) {
            // Ищет в избранном песню
            for song in list.unwrapSongs {
                if(self.id == song.id) {
                    return true
                }
            }
        }
        return false
    }
    
    func saveToList(name: String, context: NSManagedObjectContext) {
        if(!self.isSaveInList(name: name, context: context)) {
            if let list = Playlist.getList(name: name, context: context) {
                list.addToSongs(self)
                if(context.hasChanges) {
                    try? context.save()
                }
            }
        }
    }
}
