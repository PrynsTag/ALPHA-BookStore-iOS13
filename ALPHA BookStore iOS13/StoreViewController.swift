//
//  StoreViewController.swift
//  ALPHA BookStore iOS13
//
//  Created by Prince Carl Velasco on 7/17/21.
//

import UIKit

class StoreViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var bookManager = BookManager()
    
    var books = [BookData]()
    
//    var books: [BookData] = [
//        BookData(title: "Unlocking Android", pageCount: 416	, thumbnailUrl: "https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/ableson.jpg", authors: ["W. Frank Ableson", "Charlie Collins", "Robi Sen"]),
//        BookData(title: "Android in Action, Second Edition", pageCount: 592, thumbnailUrl: "https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/ableson2.jpg", authors: ["W. Frank Ableson", "Robi Sen"]),
//        BookData(title: "Specification by Example", pageCount: 123, thumbnailUrl: "https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/adzic.jpg", authors: ["Gojko Adzic"])
//
//    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        bookManager.delegate = self
        bookManager.fetchBook()
    }
}

extension StoreViewController: BookManagerDelegate {
    func fetchBookData(_ bookManager: BookManager, bookData: [BookData]) {
        DispatchQueue.main.async {
            self.books.append(contentsOf: bookData[0..<20])
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension StoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! BookCell
        
        DispatchQueue.main.async { [self] in
            cell.title?.text = books[indexPath.row].title
            
            // Image
            if let url = URL(string: (books[indexPath.row].thumbnailUrl) ?? "") {
                let data = try? Data(contentsOf: url)
                cell.bookImage.contentMode = .scaleToFill
                cell.bookImage.image = UIImage(data: data!)
                
                cell.author?.text = books[indexPath.row].authors.joined(separator: "\n")
                cell.page?.text = "\(books[indexPath.row].pageCount)"
                cell.title?.text = books[indexPath.row].title
                cell.price?.text = "\(Int.random(in: 100..<999))"
            }
        }
        
        return cell
    }
}

extension StoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
