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
    let networkService: NetworkService = NetworkService()
    
    
    enum requestType {
        case top10, all
    }
    
    init(_ type : requestType){
        switch type {
        case .top10:
            self.getTop10()
        case .all:
            self.getAll(sortby: Sortby.name, inverse: false, onlyby: Onlyby.all)
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
    
    func getAll(sortby: Sortby, inverse: Bool, onlyby: Onlyby) {
        self.connect = .loading
        // Выбор сортировки
        var urlstr : String = "http://130.193.53.242:8080/api/get/all"
        switch(sortby) {
        case .name:
            urlstr += "?sortby=name"
            break
        case .author:
            urlstr += "?sortby=author"
            break
        case .views:
            urlstr += "?sortby=views"
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
                    self.songs = songs
                }
            case .failure(let error):
                self.connect = .error
                print(error.localizedDescription)
            }
        }
    }
    
    func search(searchstr: String, searchby: Searchby, sortby: Sortby, inverse: Bool, onlyby : Onlyby) {
        self.connect = .loading
        var urlstr : String
        switch(searchby) {
        case .name:
            urlstr = "http://localhost:8080/api/get/findname"
        case .author:
            urlstr = "http://localhost:8080/api/get/findauthor"
        case .text:
            urlstr = "http://localhost:8080/api/get/findtext"
        }
        switch(sortby) {
        case .name:
            urlstr += "?sortby=name"
        case .author:
            urlstr += "?sortby=author"
        case .views:
            urlstr += "?sortby=views"
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
        urlstr += "&value=\(searchstr)"
        //print(urlstr)
        // Запрос
        networkService.baseRequest(url: urlstr) { result in
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
