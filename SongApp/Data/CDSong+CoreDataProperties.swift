//
//  CDSong+CoreDataProperties.swift
//  SongApp
//
//  Created by Давид Лисицын on 12.06.2022.
//
//

import Foundation
import CoreData


extension CDSong {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDSong> {
        return NSFetchRequest<CDSong>(entityName: "CDSong")
    }

    @NSManaged public var author: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var text: String?
    @NSManaged public var views: Int32
    @NSManaged public var playlists: NSSet?

}

// MARK: Generated accessors for playlists
extension CDSong {

    @objc(addPlaylistsObject:)
    @NSManaged public func addToPlaylists(_ value: Playlist)

    @objc(removePlaylistsObject:)
    @NSManaged public func removeFromPlaylists(_ value: Playlist)

    @objc(addPlaylists:)
    @NSManaged public func addToPlaylists(_ values: NSSet)

    @objc(removePlaylists:)
    @NSManaged public func removeFromPlaylists(_ values: NSSet)

}

extension CDSong : Identifiable {

}
