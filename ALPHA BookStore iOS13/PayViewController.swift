//
//  PayViewController.swift
//  ALPHA BookStore iOS13
//
//  Created by Prince Carl Velasco on 7/20/21.
//

import UIKit

class PayViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var priceLabel: UILabel!
    
    var selectedBooks: [BookData]!
    var sumOfBook: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        tableView.allowsSelection = false
    }
}

extension PayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sumOfBook = selectedBooks.map { $0 }.map { $0.price! }.reduce(0, +)
        priceLabel.text = "\(sumOfBook)"
        return selectedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! BookCell
        
        DispatchQueue.main.async { [self] in
            cell.title?.text = selectedBooks[indexPath.row].title
            
            // Image
            if let url = URL(string: selectedBooks[indexPath.row].thumbnailUrl!) {
                let data = try? Data(contentsOf: url)
                cell.bookImage.image = UIImage(data: data!)
                cell.bookImage.contentMode = .scaleToFill
                
                cell.author?.text = selectedBooks[indexPath.row].authors.joined(separator: "\n")
                cell.page?.text = "\(selectedBooks[indexPath.row].pageCount)"
                cell.title?.text = selectedBooks[indexPath.row].title
                cell.price?.text = "\(selectedBooks[indexPath.row].price!)"
            }
        }
        return cell
    }
}
