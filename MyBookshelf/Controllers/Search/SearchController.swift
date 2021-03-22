//
//  SearchController.swift
//  MyBookshelf
//
//  Created by JS Kim on 2021/03/18.
//

import UIKit

class SearchController: UIViewController {
    //MARK: View Components
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Search Book"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    var searchController: UISearchController?
    var searchResultTable: UITableView!
    
    //MARK: Vars
    let cellId = "searchResultTableCell"
    var searchText: String?
//    var searchedHistory: [Book]
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearch()
        layoutUI()
    }
    
    //MARK: Setup and layout logic
    final private func setUpSearch() {
        setUpSearchBar()
        setUpTableView()
    }
    
    final private func setUpSearchBar() {
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController?.hidesNavigationBarDuringPresentation = false
        self.searchController?.obscuresBackgroundDuringPresentation = false
        self.searchController?.searchBar.placeholder = "Enter BookName"
        self.searchController?.searchResultsUpdater = self
    }
    
    final private func setUpTableView() {
        self.searchResultTable = UITableView(frame: .zero)
        searchResultTable.register(SearchResultTableViewCell.self, forCellReuseIdentifier: cellId)
        searchResultTable.tableFooterView = UIView()
        searchResultTable.dataSource = self
        searchResultTable.delegate = self
        searchResultTable.backgroundColor = UIColor.clear
    }
    
    final private func layoutUI() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(searchResultTable)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            searchResultTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchResultTable.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchResultTable.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            searchResultTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
