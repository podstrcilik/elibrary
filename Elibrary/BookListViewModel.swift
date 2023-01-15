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

    init() {}

    public func fetchBooks() {
        Networking.shared.getRequest(to: "/api/v1/book", then: { (result) in
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
}

struct BookListApi: Codable {
    var books: [Book]
}
