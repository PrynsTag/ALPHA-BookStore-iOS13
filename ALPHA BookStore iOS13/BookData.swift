//
//  Book.swift
//  ALPHA BookStore iOS13
//
//  Created by Prince Carl Velasco on 7/17/21.
//

import Foundation

struct BookInfo: Codable  {
    let bookInfo: BookData
}

struct BookData: Codable {
    let title: String
    let pageCount: Int
    let thumbnailUrl: String?
    let authors: [String]
    let price: Int?
}
