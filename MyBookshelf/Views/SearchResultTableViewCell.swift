//
//  SearchResultTableViewCell.swift
//  MyBookshelf
//
//  Created by JS Kim on 2021/03/21.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    //MARK: UI Components
    let bookThumbnail: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.adjustsFontSizeToFitWidth = true
        l.minimumScaleFactor = 0.7
        return l
    }()
    
    let subtitleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.adjustsFontSizeToFitWidth = false
        l.minimumScaleFactor = 0.5
        return l
    }()
    
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func prepareForReuse() {
        self.bookThumbnail.text = ""
        self.imageView!.image = nil
    }
    
    func set(book: Book) {
        titleLabel.text = book.title
        subtitleLabel.text = book.subtitle
        if book.image != "" {
            getImage(imageUrl: book.image)
        } else {
            DispatchQueue.main.async {
                self.imageView?.image = UIImage(imageLiteralResourceName: "error")
                self.imageView?.reloadInputViews()
            }
        }
    }
    
    func getImage(imageUrl: String) {
        NetworkManager.shared.getImage(urlString: imageUrl) { [weak self] result in
            switch result {
            case.failure(let error):
                DispatchQueue.main.async {
                    self?.imageView?.image = UIImage(imageLiteralResourceName: "error")
                    self?.imageView?.reloadInputViews()
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imageView?.image = image
                    self?.imageView?.reloadInputViews()
                }
            }
        }
    }
    
    
    //MARK: Config and layout logic
    private func layoutUI() {
        self.addSubview(bookThumbnail)
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            bookThumbnail.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            bookThumbnail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            bookThumbnail.heightAnchor.constraint(equalTo: self.heightAnchor,constant: -10),
            bookThumbnail.widthAnchor.constraint(equalTo: self.heightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.bookThumbnail.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            
            subtitleLabel.topAnchor.constraint(equalTo: self.centerYAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: self.bookThumbnail.trailingAnchor, constant: 10),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
