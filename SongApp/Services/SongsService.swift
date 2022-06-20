//
//  SongsService.swift
//  SongApp
//
//  Created by Давид Лисицын on 08.06.2022.
//

import Foundation

final class SongsService: ObservableObject {
    @Published var songs: [Song] = []
    @Published var connect: Connect = .loading
    @Published var count : Int = 1
    let networkService: NetworkService = NetworkService()
    
    
    enum requestType {
        case top10, all
    }
    
    init(_ type : requestType){
        switch type {
        case .top10:
            self.getTop10()
        case .all:
            self.getAll(sortby: Sortby.name, inverse: false, onlyby: Onlyby.all, update: true)
        }
    }
    
    func updateData(searchString : String, searchby : Searchby, sortby : Sortby, inverse : Bool, onlyby : Onlyby) {
        if searchString.isEmpty {
            getAll(sortby: sortby, inverse: inverse, onlyby: onlyby,update: true)
        } else {
            search(searchString: searchString, searchby: searchby, sortby: sortby, inverse: inverse, onlyby: onlyby, update: true)
        }
    }
    
    func resetData(searchString : String, searchby : Searchby, sortby : Sortby, inverse : Bool, onlyby : Onlyby) {
        self.count = 1
        if searchString.isEmpty {
            getAll(sortby: sortby, inverse: inverse, onlyby: onlyby)
        } else {
            search(searchString: searchString, searchby: searchby, sortby: sortby, inverse: inverse, onlyby: onlyby)
        }
    }
    
    func getAll(sortby: Sortby, inverse: Bool, onlyby: Onlyby, update : Bool = false) {
        self.connect = .loading
        
        // Выбор сортировки
        var urlstr : String = "http://130.193.53.242:8080/api/get/all?start=\(count)&rows=20"
        print(urlstr)
        switch(sortby) {
        case .name:
            urlstr += "&sortby=name"
            break
        case .author:
            urlstr += "&sortby=author"
            break
        case .views:
            urlstr += "&sortby=views"
            break
        }
        switch(onlyby) {
        case .all:
            urlstr += "&onlyby=all"
        case .english:
            urlstr += "&onlyby=author"
        case .russian:
            urlstr += "&onlyby=russian"
//        case .christian:
//            urlstr += "&onlyby=christian"
        }
        if(inverse){
            urlstr += "&inverse=true"
        }
        // Запрос
        networkService.baseRequest(url: urlstr) { result in
            switch result {
            case .success(let songs):
                self.connect = .ok
                DispatchQueue.main.async {
                    var oldSongs : [Song] = []
                    if update {
                        oldSongs = self.songs
                    }
                    self.songs = oldSongs + songs
                    if !songs.isEmpty {self.count += 10}
                    print("Songs count = \(self.songs.count)")
                }
            case .failure(let error):
                self.connect = .error
                print(error.localizedDescription)
            }
        }
    }
    
    func search(searchString: String, searchby: Searchby, sortby: Sortby, inverse: Bool, onlyby : Onlyby, update : Bool = false) {
        self.connect = .loading
        var urlstr : String
        switch(searchby) {
        case .name:
            urlstr = "http://130.193.53.242:8080/api/get/findname?start=\(count)&rows=20"
        case .author:
            urlstr = "http://130.193.53.242:8080/api/get/findauthor?start=\(count)&rows=20"
        case .text:
            urlstr = "http://130.193.53.242:8080/api/get/findtext?start=\(count)&rows=20"
        }
        switch(sortby) {
        case .name:
            urlstr += "&sortby=name"
        case .author:
            urlstr += "&sortby=author"
        case .views:
            urlstr += "&sortby=views"
        }
        switch(onlyby) {
        case .all:
            urlstr += "&onlyby=all"
        case .english:
            urlstr += "&onlyby=author"
        case .russian:
            urlstr += "&onlyby=russian"
//        case .christian:
//            urlstr += "&onlyby=christian"
        }
        if(inverse){
            urlstr += "&inverse=true"
        }
        urlstr += "&value=\(searchString)"
        //print(urlstr)
        // Запрос
        print(urlstr)
        networkService.baseRequest(url: urlstr) { result in
            switch result {
            case .success(let songs):
                self.connect = .ok
                DispatchQueue.main.async {
                    var oldSongs : [Song] = []
                    if update {
                        oldSongs = self.songs
                    }
                    self.songs = oldSongs + songs
                    if !songs.isEmpty {self.count += 10}
                    print("Songs count = \(self.songs.count)")
                }
            case .failure(let error):
                self.connect = .error
                print(error.localizedDescription)
            }
        }
    }
    
    func getOne(id: Int) {
        self.connect = .loading
        networkService.baseRequest(url: "http://130.193.53.242:8080/api/get/\(id)") { result in
            switch result {
            case .success(let songs):
                self.connect = .ok
                DispatchQueue.main.async {
                    self.songs = songs
                }
            case .failure(let error):
                self.connect = .error
                print(error.localizedDescription)
            }
        }
    }
    
    func getTop10() {
        self.connect = .loading
        networkService.baseRequest(url: "http://130.193.53.242:8080/api/get/top10") { result in
            switch result {
            case .success(let songs):
                self.connect = .ok
                DispatchQueue.main.async {
                    self.songs = songs
                }
            case .failure(let error):
                self.connect = .error
                print(error.localizedDescription)
            }
        }
    }
    
//    func isConnect() -> Bool {
//        networkService.baseRequest(url: "http://130.193.53.242:8080/api/check") { result in
//            switch result {
//            case .success(_):
//                self.connect = true
//            case .failure(let error):
//                self.connect = false
//                print(error.localizedDescription)
//            }
//        }
//        return self.connect
//    }
}

enum Connect {
    case loading
    case error
    case ok
}
