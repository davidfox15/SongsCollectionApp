//
//  Playlist+CoreDataClass.swift
//  SongApp
//
//  Created by Давид Лисицын on 08.06.2022.
//
//

import Foundation
import CoreData

@objc(Playlist)
public class Playlist: NSManagedObject {
    
    public var unwrapName : String {
        name ?? "Unknow Playlist"
    }

    public var unwrapSongs : [CDSong] {
        if songs != nil{
            return songs!.toArray()
        } else {
            return []
        }
    }
    
    static func getAll() -> NSFetchRequest<Playlist> {
        let request : NSFetchRequest<Playlist> = Playlist.fetchRequest()
        let sortDescriptor: NSSortDescriptor = NSSortDescriptor(keyPath: \Playlist.name, ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }
    
    static func getFavoriteList(context: NSManagedObjectContext) -> Playlist {
        // поиск в контексте избранного
        let request = Playlist.getAll()
        let array : [Playlist]
        do {
            array = try context.fetch(request)
            for item in array {
                if(item.unwrapName != "Favorite") {
                    return item
                }
            }
        } catch(let error) {
            print("isSave fetcherror -\(error)")
        }
        
        // если в контексте не было найденно избранного
        let favoriteList = Playlist(context: context)
        favoriteList.name = "Favorite"
        return favoriteList
    }
}

extension NSSet {
    func toArray<T>() -> [T] {
        let array = self.map({ $0 as! T})
        return array
    }
}
