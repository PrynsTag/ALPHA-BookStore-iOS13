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
    var selectedBooks = [BookData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        bookManager.delegate = self
        
        tableView.dataSource = self
        bookManager.fetchBook()
        
        tableView.register(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        tableView.allowsMultipleSelection = true
    }
    
    @IBAction func checkoutButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "goToPay", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPay" {
            let destinationVC = segue.destination as! PayViewController
            destinationVC.selectedBooks = selectedBooks
        }
    }
}

extension StoreViewController: BookManagerDelegate {
    func fetchBookData(_ bookManager: BookManager, bookData: [BookData]) {
        DispatchQueue.main.async { [self] in
            books.append(contentsOf: bookData)
            tableView.reloadData()
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
            if let url = URL(string: books[indexPath.row].thumbnailUrl ?? "") {
                let data = try? Data(contentsOf: url)
                cell.bookImage.image = UIImage(data: data!)
                cell.bookImage.contentMode = .scaleToFill
                
                cell.title?.text = books[indexPath.row].title
                cell.author?.text = books[indexPath.row].authors.joined(separator: "\n")
                cell.page?.text = "\(books[indexPath.row].pageCount)"
                cell.title?.text = books[indexPath.row].title
                
                books[indexPath.row].price = Int.random(in: 100..<999)
                cell.price?.text = "\(books[indexPath.row].price!)"
            }
        }
        return cell
    }
}

extension StoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            selectedBooks.append(books[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
            selectedBooks = selectedBooks.filter { $0.title != books[indexPath.row].title }
        }
    }
}
