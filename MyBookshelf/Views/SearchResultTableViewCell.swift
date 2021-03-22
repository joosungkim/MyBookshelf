//
//  SearchResultTableViewCell.swift
//  MyBookshelf
//
//  Created by JS Kim on 2021/03/21.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    //MARK: UI Components
    var bookThumbnail: UILabel = {
      let l = UILabel()
      l.translatesAutoresizingMaskIntoConstraints = false
      return l
    }()
    
    var countryLabel: UILabel = {
      let l = UILabel()
      l.translatesAutoresizingMaskIntoConstraints = false
      l.adjustsFontSizeToFitWidth = true
      l.minimumScaleFactor = 0.7
      return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      addSubview(bookThumbnail)
      addSubview(countryLabel)
      
      bookThumbnailConstraints()
      countryLabelConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
      return nil
    }
    
    
    //MARK: Config and layout logic
    private final func bookThumbnailConstraints() {
        NSLayoutConstraint.activate([
            bookThumbnail.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            bookThumbnail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            bookThumbnail.widthAnchor.constraint(equalToConstant: 40),
            bookThumbnail.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    private final func countryLabelConstraints() {
        NSLayoutConstraint.activate([
            countryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            countryLabel.leadingAnchor.constraint(equalTo: bookThumbnail.trailingAnchor, constant: 10),
            countryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            countryLabel.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
}
