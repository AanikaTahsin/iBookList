//
//  Books.swift
//  iBookList
//
//  Created by Anika Tahsin Chowdhury on 21/3/23.
//

import Foundation

struct Books: Decodable {
    var id: Int
    var title: String
    var isbn: String
    var price: Int
    var currencyCode: String
    var author: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case isbn = "isbn"
        case price = "price"
        case currencyCode = "currencyCode"
        case author = "author"
    }
}

struct BookDetails: Decodable {
    enum Category: String, Decodable {
        case id, title, isbn, description, price, currencyCode, author
    }

    let id: Int
    let title: String
    let isbn: String
    let description: String
    let price: Int
    let currencyCode: String
    let author: String
    
}
