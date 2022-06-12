//
//  Playlist+CoreDataProperties.swift
//  SongApp
//
//  Created by Давид Лисицын on 11.06.2022.
//
//

import Foundation
import CoreData


extension Playlist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Playlist> {
        return NSFetchRequest<Playlist>(entityName: "Playlist")
    }

    @NSManaged public var name: String?
    @NSManaged public var songs: NSSet?

}

// MARK: Generated accessors for songs
extension Playlist {

    @objc(addSongsObject:)
    @NSManaged public func addToSongs(_ value: CDSong)

    @objc(removeSongsObject:)
    @NSManaged public func removeFromSongs(_ value: CDSong)

    @objc(addSongs:)
    @NSManaged public func addToSongs(_ values: NSSet)

    @objc(removeSongs:)
    @NSManaged public func removeFromSongs(_ values: NSSet)

}

extension Playlist : Identifiable {

}
