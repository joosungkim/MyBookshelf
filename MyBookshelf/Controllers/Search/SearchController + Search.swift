//
//  SearchController + Search.swift
//  MyBookshelf
//
//  Created by JS Kim on 2021/03/21.
//

import UIKit

extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchResults.removeAll()
        if searchController.searchBar.text != ""{
            self.currentPage = 1
            updateResultsForSearch(searchController.searchBar.text!)
        } else {
            updateResultsToHistory()
        }
    }
    
    
    private func updateResultsForSearch(_ text: String) {
        networkManager.getSearchResult(for: text, page: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.searchResults = result.books
                print("result: \(result.books)")
                DispatchQueue.main.async {
                    self.searchResultTable.reloadData()
                }
            case .failure(let error):
                print("failed: \(error)")
            }
        }
    }
    
    @objc func pullDownToGetMorePages() {
        //increment page
        currentPage += 1
        
    }
    
    private func updateResultsToHistory() {
        print("history")
    }
}
