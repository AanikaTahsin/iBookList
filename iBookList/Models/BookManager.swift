//
//  BookManager.swift
//  iBookList
//
//  Created by Anika Tahsin Chowdhury on 21/3/23.
//

import Foundation

class BookManager {
    let bookListURL = "https://tpbookserver.herokuapp.com/books"
    let errorCode = 500

    public typealias BookListCompletionBlock = (_ data: [Books]?) -> ()
    public typealias BookDetailsCompletionBlock = (_ data: BookDetails?) -> ()
    
    open class func sharedBookManager() -> BookManager {
      return _sharedBookManager
    }
    
    func getBookList( completion: @escaping BookListCompletionBlock) {
        
        var request = URLRequest(url: URL(string: bookListURL)!)
        request.httpMethod = "GET"
        
        var bookList: [Books] = []
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            guard let data = data , error == nil else {
                 return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                bookList = try jsonDecoder.decode([Books].self, from: data)
                completion(bookList)
            } catch {
                print("JSON Serialization error \(error)")
            }
        })
        
        task.resume()
    }

    func getBookDetails(_ id : Int, completion: @escaping BookDetailsCompletionBlock) {
        
        let currentBookURL = "https://tpbookserver.herokuapp.com/book/\(id)"
        
        var request = URLRequest(url: URL(string: currentBookURL)!)
        request.httpMethod = "GET"
        
        var bookDetails: BookDetails?
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data , error == nil else {
                 return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == self.errorCode {
                    completion(bookDetails)
                }
            }

            do {
                let jsonDecoder = JSONDecoder()
                bookDetails = try jsonDecoder.decode(BookDetails.self, from: data)
                print("data: \(data)")
                completion(bookDetails)
            } catch {
                print("JSON Serialization error \(error)")
            }
        })
        
        task.resume()
    }
    
}

let _sharedBookManager: BookManager = { BookManager() }()
