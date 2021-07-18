//
//  BookCell.swift
//  ALPHA BookStore iOS13
//
//  Created by Prince Carl Velasco on 7/17/21.
//

import UIKit

class BookCell: UITableViewCell {
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var page: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
