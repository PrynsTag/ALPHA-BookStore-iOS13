//
//  PayViewController.swift
//  ALPHA BookStore iOS13
//
//  Created by Prince Carl Velasco on 7/20/21.
//

import UIKit

class PayViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var selectedBooks: [BookData]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: "ReusablePayCell")
    }
}

extension PayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusablePayCell", for: indexPath) as! BookCell
        
        DispatchQueue.main.async { [self] in
            cell.title?.text = selectedBooks[indexPath.row].title
            
            // Image
            if let url = URL(string: (selectedBooks[indexPath.row].thumbnailUrl) ?? "") {
                let data = try? Data(contentsOf: url)
                cell.bookImage.image = UIImage(data: data!)
                cell.bookImage.contentMode = .scaleToFill
                
                cell.author?.text = selectedBooks[indexPath.row].authors.joined(separator: "\n")
                cell.page?.text = "\(selectedBooks[indexPath.row].pageCount)"
                cell.title?.text = selectedBooks[indexPath.row].title
                cell.price?.text = "\(Int.random(in: 100..<999))"
            }
        }
        
        return cell
    }
}
