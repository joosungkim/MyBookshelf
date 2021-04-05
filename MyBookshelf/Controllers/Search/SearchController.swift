//
//  SearchController.swift
//  MyBookshelf
//
//  Created by JS Kim on 2021/03/18.
//

import UIKit

class SearchController: UIViewController {
    //MARK: Helpers
    let networkManager = NetworkManager.shared
    
    //MARK: View Components
    var searchController: UISearchController?
    var searchResultTable: UITableView!
    
    //MARK: Vars
    let cellId = "searchResultTableCell"
    var searchText: String?
    var searchResults: [Book?] = []
    var currentPage = 1
    var searchHistory: [Book] = []
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Book"
        setUpTableView()
        layoutUI()
        setUpSearchBar()
    }

    //MARK: Setup and layout logic
    private func setUpSearchBar() {
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchResultTable.tableHeaderView = searchController?.searchBar
        self.searchController?.hidesNavigationBarDuringPresentation = false
        self.searchController?.obscuresBackgroundDuringPresentation = false
        self.searchController?.searchBar.placeholder = "Enter BookName"
        self.searchController?.searchResultsUpdater = self
    }
    
    private func setUpTableView() {
        self.searchResultTable = UITableView(frame: .zero)
        self.searchResultTable.register(SearchResultTableViewCell.self, forCellReuseIdentifier: cellId)
        self.searchResultTable.dataSource = self
        self.searchResultTable.delegate = self
        self.searchResultTable.backgroundColor = UIColor.clear
    }
    
    private func layoutUI() {
        self.view.addSubview(searchResultTable)
        self.view.backgroundColor = .white
        self.searchResultTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchResultTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            searchResultTable.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            searchResultTable.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            searchResultTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
