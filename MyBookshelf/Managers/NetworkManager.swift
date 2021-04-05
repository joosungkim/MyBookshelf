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
    func getSearchResult(for keyWord: String, page: Int = 1, completionHandler: @escaping (Result<SearchResult, BookshelfError>) -> Void) {
        let endpoint = baseURL + "/search/\(keyWord)/\(page)"
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
                let result = try JSONDecoder().decode(SearchResult.self, from: data)
                
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(.decodeError))
            }
        }.resume()
    }
    
    func getImage(urlString: String, completionHandler: @escaping (Result<UIImage, BookshelfError>) -> Void) {
        if let image = cache.object(forKey: NSString(string: urlString)) {
            completionHandler(.success(image))
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        session.dataTask(with: url) {[weak self] (data, response, error) in
            guard error == nil else {
                completionHandler(.failure(.clientError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completionHandler(.failure(.serverError))
                return
            }
                        
            guard let data = data else {
                completionHandler(.failure(.dataError))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completionHandler(.failure(.dataError))
                return
            }
            
            self?.cache.setObject(image, forKey: NSString(string: urlString))
            completionHandler(.success(image))
        }.resume()
    }
    
    func getDetail(isbn: String, completionHandler: @escaping (Result<BookDetail, BookshelfError>) -> Void) {
        let endpoint = baseURL + "/books/\(isbn)"
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
                let result = try JSONDecoder().decode(BookDetail.self, from: data)                
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(.decodeError))
            }
        }.resume()
    }
}
