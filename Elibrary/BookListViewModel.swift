//
//  BookListViewModel.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 14.12.2022.
//

import Foundation
import SwiftUI

class BookListViewModel: ObservableObject {
    @Published var books: [Book] = []
    var orderKey: String?

    init() {}

    public func fetchBooks(search: String? = nil) {
        

        var url = "/api/v1/book"

        if let search {
            url += "?search=\(search)"
        }

        if let orderKey {
            if search != nil {
                url += "&"
            } else {
                url += "?"
            }
            url += "order[\(orderKey)]=DESC"
        }

        Networking.shared.getRequest(to: url, then: { (result) in
            if case .success(let succesData) = result {
                do {
                    let results = try JSONDecoder().decode(GenericCollectionNetworkLayer<Book>.self, from: succesData)
                    DispatchQueue.main.async {
                        self.books = results.data
                    }
                }
                catch {
                    print(error)
                }
            }
        })
    }


    public func deleteBook(id: String) {
        Networking.shared.deleteRequest(to: "/api/v1/book/\(id)", then: { (result) in
            if case .success(let succesData) = result {
                do {
                    self.fetchBooks()
                }
                catch {
                    print(error)
                }
            }
        })
    }
}

struct BookListApi: Codable {
    var books: [Book]
}
