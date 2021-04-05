//
//  SearchResult.swift
//  MyBookshelf
//
//  Created by JS Kim on 2021/03/22.
//

import Foundation

// MARK: - Welcome
struct SearchResult: Codable {
    let error, total: String
    let page: String?
    var books: [Book]
    
    enum Keys: String, CodingKey {
        case error
        case total
        case page
        case books
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        error = try! container.decode(String.self, forKey: .error)
        total = try! container.decode(String.self, forKey: .total)
        page = try? container.decode(String.self, forKey: .page)
        books =  (try? container.decode([Book].self, forKey: . books)) ?? []
    }
}

// MARK: - Book
struct Book: Codable {
    let title, subtitle, isbn13, price: String
    let image: String
    let url: String
}

extension Book: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(isbn13)
    }
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.isbn13 == rhs.isbn13 
    }
}
