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
            self.books.append(contentsOf: bookData[20..<40])
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
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
}
