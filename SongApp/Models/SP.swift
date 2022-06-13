//
//  SP.swift
//  SongApp
//
//  Created by Давид Лисицын on 12.06.2022.
//

import Foundation
import CoreData

protocol SP {
    func getname() -> String
    func getauthor() -> String
    func gettext() -> String
    func getviews() -> Int32
    func getid() -> Int32
    
    func isSaveInFavoriteList(context: NSManagedObjectContext) -> Bool
    func saveToFavorite(context: NSManagedObjectContext)
    
    func isSaveInList(name: String, context: NSManagedObjectContext) -> Bool
    func saveToList(name: String, context: NSManagedObjectContext)
}
