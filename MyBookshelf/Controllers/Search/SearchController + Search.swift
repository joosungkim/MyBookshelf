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
        NetworkManager.shared.getSearchResult(for: text, page: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.searchResults = result.books
                self.total = Int(result.total)!
                DispatchQueue.main.async {
                    self.searchResultTable.reloadData()
                }
            case .failure(let error):
                print("failed: \(error)")
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard total > (currentPage + 1) * 10 else { return }
        
        let contentHeight = scrollView.contentSize.height
        let contentOffset = scrollView.contentOffset.y
        let scrollViewFrameHeight = scrollView.frame.size.height
        
        if (scrollViewFrameHeight + contentOffset) > (contentHeight - 200)  {
            if let text = searchController?.searchBar.text {
                NetworkManager.shared.getSearchResult(for: text, page: currentPage + 1) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let result):
                        self.searchResults.append(contentsOf: result.books)
                        if let page = result.page {
                            self.currentPage = Int(page)!
                        }
                        DispatchQueue.main.async {
                            self.searchResultTable.reloadData()
                        }
                    case .failure(let error):
                        print("failed: \(error)")
                    }
                }
            }
        }
    }

    private func updateResultsToHistory() {
        self.getHistory()
        DispatchQueue.main.async {
            self.searchResultTable.reloadData()
        }
    }
}
