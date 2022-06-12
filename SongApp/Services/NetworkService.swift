//
//  NetworkService.swift
//  SongApp
//
//  Created by Давид Лисицын on 08.06.2022.
//

import Foundation

class NetworkService {
    //private let urlSession = URLSession(configuration: .default)
    func baseRequest (url: String, completion: @escaping (Result<[Song], Error>) -> Void) {
        // Создаем URL
        guard let url = URL(string: url.encodeUrl) else {
            completion(.failure(NetworkError.wrongUrl))
            return
        }
        // Инициализируем сессию
        //let session = URLSession(configuration: .default)
        // Создаем запрос dataTask
        let task = URLSession.shared.dataTask(with: url) {(data: Data?, response: URLResponse?, error: Error?) -> Void in
            //Обрабатываем ошибку
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            // Обрабатываем полученные данные
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.dataIsNil))
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                
                // Декодируем данные обьект T
                let decodedObject = try decoder.decode([Song].self, from: data)
                
//                var newobject : [Song] = []
//                for item in decodedObject {
//                    newobject.append(item.converToSong(context: <#T##NSManagedObjectContext#>))
//                }
                
                DispatchQueue.main.async {
                    completion(.success(decodedObject))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case wrongUrl
    case dataIsNil
}

extension String{
    var encodeUrl : String
    {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl : String
    {
        return self.removingPercentEncoding!
    }
}
