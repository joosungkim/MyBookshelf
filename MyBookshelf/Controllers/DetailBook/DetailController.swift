//
//  DetailController.swift
//  MyBookshelf
//
//  Created by JS Kim on 2021/04/05.
//

import UIKit
import SafariServices

class DetailController: UIViewController {
    //MARK: Vars
    var cvCellId = "cvCellId"
    var book: Book?
    var bookDetail: BookDetail?
    
    //MARK: ViewComponents
    lazy var detailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.sectionHeadersPinToVisibleBounds = true
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        return cv
    } ()
    
    let bookThumbnail: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(imageLiteralResourceName: "error")
        return iv
    }()
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.adjustsFontSizeToFitWidth = true
        l.minimumScaleFactor = 0.5
        return l
    }()
    
    let urlButton: UIButton = {
        let but = UIButton(type: .system)
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setTitle("Open URL", for: .normal)
        but.setTitleColor(.white, for: .normal)
        but.backgroundColor = .purple
        but.addTarget(self, action: #selector(openURL), for: .touchUpInside)
        return but
    }()
    
    //MARK: Helpers
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
//        setUpCollectionView()
    }
    
    func setDetailByBook(book: Book) {
        self.book = book
        titleLabel.text = book.title
        NetworkManager.shared.getDetail(isbn: book.isbn13) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let detail):
                self.bookDetail = detail
            case .failure(let error):
                print("Detail Error: \(error)")
            }
        }
        
        NetworkManager.shared.getImage(urlString: book.image) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                self.bookThumbnail.image = image
            case .failure(let error):
                print("Detail Image Error: \(error)")
            }
        }
    }
    
    @objc func openURL() {
        if let url = bookDetail?.url {
            print(url)
            guard let url = URL(string: url) else { return }
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true)
        }
    }
    
    //MARK: Setup and layout logic
//    private func setUpCollectionView() {
//        self.detailCollectionView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: cellId)
//        self.detailCollectionView.dataSource = self
//        self.detailCollectionView.delegate = self
//        self.detailCollectionView.backgroundColor = UIColor.clear
//    }
    
    private func layoutUI() {
        view.addSubview(bookThumbnail)
        view.addSubview(titleLabel)
        view.addSubview(urlButton)
        self.view.backgroundColor = .white
        NSLayoutConstraint.activate([
            bookThumbnail.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            bookThumbnail.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            bookThumbnail.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor,constant: -10),
            bookThumbnail.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: self.bookThumbnail.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.bookThumbnail.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.bookThumbnail.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            urlButton.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            urlButton.leadingAnchor.constraint(equalTo: self.bookThumbnail.leadingAnchor),
            urlButton.trailingAnchor.constraint(equalTo: self.bookThumbnail.trailingAnchor),
            urlButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
