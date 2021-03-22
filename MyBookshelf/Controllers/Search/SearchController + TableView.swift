//
//  SearchController + TableView.swift
//  MyBookshelf
//
//  Created by JS Kim on 2021/03/21.
//

import UIKit

extension SearchController: UITableViewDelegate, UITableViewDataSource {
    //MARK: Vars
    
    //MARK: Delegate functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SearchResultTableViewCell
        if searchController!.isActive, searchController!.searchBar.text != "" {
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
