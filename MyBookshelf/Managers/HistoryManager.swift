//
//  HistoryManager.swift
//  MyBookshelf
//
//  Created by JS Kim on 2021/04/05.
//

import Foundation

//enum HistoryUpdateType {
//    case add
//    case remove
//}

class HistoryManager {
    static let shared = HistoryManager()
    
    private init() { }
    
    func addHistory(book: Book, completionHandler: (BookshelfError?) -> ()) {
        getHistory { result in
            switch result {
            case .success(var history):
                if history.contains(where: {$0 == book}) {
                    history.removeAll(where: {$0 == book})
                } else if history.count > 10 {
                    history.removeLast()
                }
                history.insert(book, at: 0)
                completionHandler(save(history: history))
            case .failure(let error):
                completionHandler(error)
            }
        }
    }
    
    func getHistory(completionHandler: (Result<[Book], BookshelfError>) -> ()) {
        let booksURL = URL(fileURLWithPath: "history.json", relativeTo: FileManager.documentDirectoryURL)
        guard FileManager.default.fileExists(atPath: booksURL.path) else {
            let emptyHistory = [Book]()
            let emptyHistoryData = try? JSONEncoder().encode(emptyHistory)
            try? emptyHistoryData?.write(to: booksURL, options: .atomicWrite)
            completionHandler(.success(emptyHistory))
            return
        }
        
        do {
            let historyData = try Data(contentsOf: booksURL)
            let history = try JSONDecoder().decode([Book].self, from: historyData)
            completionHandler(.success(history))
        } catch {
            completionHandler(.failure(.getHistoryError))
        }
    }
    
    private func save(history: [Book]) -> BookshelfError? {
        let booksURL = URL(fileURLWithPath: "history.json", relativeTo: FileManager.documentDirectoryURL)
        do {
            let historyData = try JSONEncoder().encode(history)
            try historyData.write(to: booksURL, options: .atomicWrite)
            return nil
        } catch {
            return .saveHistoryError
        }
    }
}
