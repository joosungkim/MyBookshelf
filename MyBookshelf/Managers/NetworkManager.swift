//
//  NetworkManager.swift
//  MyBookshelf
//
//  Created by JS Kim on 2021/03/22.
//

import UIKit

class NetworkManager {
    //MARK: Objects
    static let shared = NetworkManager()
    
    private let session = URLSession.shared
    private let baseURL = "https://api.itbook.store/1.0/"
    private let cache = NSCache<NSString, UIImage>()
    
    //MARK: Network Logic
    func getSearchResult(for keyWord: String, completionHandler: @escaping (SearchResult) -> Void) {
        let endpoint = baseURL + "/search/\(keyWord)"
        guard let url = URL(string: endpoint) else { return }
        
        session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completionHandler(.failure(.clientError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completionHandler(.failure(.serverError))
                return
            }
            
            guard response.mimeType == ResponseMIMEType.applicationJSON.rawValue else {
                completionHandler(.failure(.MIMEError))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.dataError))
                return
            }
            
            do {
                let user = try JSONDecoder().decode(GFUser.self, from: data)
                completionHandler(.success(user))
            } catch {
                completionHandler(.failure(.decodeError))
            }
        }.resume()
    }
}
