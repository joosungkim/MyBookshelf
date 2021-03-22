//
//  SearchResult.swift
//  MyBookshelf
//
//  Created by JS Kim on 2021/03/22.
//

import Foundation

struct SearchResult: Codable {
    let title: String
    let subtitle: String
    let isbn13: String
    let price: String
    let image: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case subtitle
        case isbn13
        case price
        case image
        case url 
    }
}

extension SearchResult: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(isbn13)
    }
    
    static func ==(lhs: SearchResult, rhs: SearchResult) -> Bool {
        return lhs.isbn13 == rhs.isbn13
    }
}
