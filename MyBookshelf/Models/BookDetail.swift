//
//  BookDetail.swift
//  MyBookshelf
//
//  Created by JS Kim on 2021/03/22.
//

import Foundation

// MARK: - BookDetail
class BookDetail: Codable {
    let error, title, subtitle, authors: String
    let publisher, language, isbn10, isbn13: String
    let pages, year, rating, desc: String
    let price: String
    let image: String
    let url: String
    let pdf: [String: String]?

    init(error: String, title: String, subtitle: String, authors: String, publisher: String, language: String, isbn10: String, isbn13: String, pages: String, year: String, rating: String, desc: String, price: String, image: String, url: String, pdf: [String:String]?) {
        self.error = error
        self.title = title
        self.subtitle = subtitle
        self.authors = authors
        self.publisher = publisher
        self.language = language
        self.isbn10 = isbn10
        self.isbn13 = isbn13
        self.pages = pages
        self.year = year
        self.rating = rating
        self.desc = desc
        self.price = price
        self.image = image
        self.url = url
        self.pdf = pdf
    }
    
    enum Keys: String, CodingKey {
        case error
        case title
        case subtitle
        case authors
        case publisher
        case language
        case isbn10
        case isbn13
        case pages
        case year
        case rating
        case desc
        case price
        case image
        case url
        case pdf
    }

    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        error = try! container.decode(String.self, forKey: .error)
        title = try! container.decode(String.self, forKey: .title)
        subtitle = try! container.decode(String.self, forKey: .subtitle)
        authors = try! container.decode(String.self, forKey: .authors)
        publisher = try! container.decode(String.self, forKey: .publisher)
        language = try! container.decode(String.self, forKey: .language)
        isbn10 = try! container.decode(String.self, forKey: .isbn10)
        isbn13 = try! container.decode(String.self, forKey: .isbn13)
        pages = try! container.decode(String.self, forKey: .pages)
        year = try! container.decode(String.self, forKey: .year)
        rating = try! container.decode(String.self, forKey: .rating)
        desc = try! container.decode(String.self, forKey: .desc)
        price = try! container.decode(String.self, forKey: .price)
        image = try! container.decode(String.self, forKey: .image)
        url = try! container.decode(String.self, forKey: .url)
        pdf = try? container.decode([String: String].self, forKey: .pdf)
    }
}


extension BookDetail: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(isbn13)
    }
    
    static func ==(lhs: BookDetail, rhs: BookDetail) -> Bool {
        return lhs.isbn13 == rhs.isbn13
    }
}
