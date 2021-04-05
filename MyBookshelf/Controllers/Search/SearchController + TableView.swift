//
//  SearchController + TableView.swift
//  MyBookshelf
//
//  Created by JS Kim on 2021/03/21.
//

import UIKit

extension SearchController: UITableViewDelegate, UITableViewDataSource {    
    //MARK: Delegate functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController!.isActive, searchController!.searchBar.text != ""{
            return searchResults.count == 0 ? 1: searchResults.count
        }
        return searchHistory.count == 0 ? 1: searchHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as!  SearchResultTableViewCell
        if searchController!.isActive, searchController!.searchBar.text != ""{
            if searchResults.count > 0 {
                cell.set(book: searchResults[indexPath.row]!)
            } else { // no results
                cell.set(book: .init(title: "No Search Result", subtitle: "", isbn13: "", price: "", image: "", url: ""))
            }
        } else { //show history
            if searchHistory.count != 0 {
                cell.set(book: searchHistory[indexPath.row])
            } else { //no history
                cell.set(book: .init(title: "No Search History", subtitle: "", isbn13: "", price: "", image: "", url: ""))
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController!.isActive, searchController!.searchBar.text != "", searchResults.count  != 0 {
            let detailController = DetailController()
            let selectedBook = searchResults[indexPath.row]!
            detailController.setDetailByBook(book: selectedBook)
            self.navigationController?.pushViewController(detailController, animated: true)
            HistoryManager.shared.addHistory(book: selectedBook) { (error) in
                print("error: \(error)")
            }
        } else if searchHistory.count != 0 {
            let detailController = DetailController()
            detailController.setDetailByBook(book: searchHistory[indexPath.row])
            self.navigationController?.pushViewController(detailController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
