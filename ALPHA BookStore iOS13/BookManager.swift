//
//  BookManager.swift
//  ALPHA BookStore iOS13
//
//  Created by Prince Carl Velasco on 7/18/21.
//

import Foundation

protocol BookManagerDelegate {
    func fetchBookData(_ bookManager: BookManager, bookData: [BookData])
    func didFailWithError(error: Error)
}

struct BookManager {
    let bookURL = "https://raw.githubusercontent.com/bvaughn/infinite-list-reflow-examples/master/books.json"
    
    var delegate: BookManagerDelegate?
    
    func fetchBook() { performRequest(with: bookURL) }
    
    func performRequest(with url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response,  error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let book = self.parseJSON(safeData) { self.delegate?.fetchBookData(self, bookData: book) }
                }  
            }
            task.resume()
        }
        
    }
    
    func parseJSON(_ bookData: Data) -> [BookData]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([BookData].self, from: bookData)
            return decodedData
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
