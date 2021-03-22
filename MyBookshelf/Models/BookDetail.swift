//
//  BookDetail.swift
//  MyBookshelf
//
//  Created by JS Kim on 2021/03/22.
//

import Foundation

struct BookDetail: Codable {
    let error: String
    let authors: String
    let publisher: String
    let isbn10: String
    let pages: String
    let year: String
    let rating: String
    let desc: String
    let pdf: [String]
    let searchResult: SearchResult
    
}

extension BookDetail: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(searchResult)
    }
    
    static func ==(lhs: BookDetail, rhs: BookDetail) -> Bool {
        return lhs.searchResult.isbn13 == rhs.searchResult.isbn13
    }
}
