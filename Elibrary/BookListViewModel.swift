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
        guard let url = URL(string: "http://127.0.0.1:3001/books") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(BookListApi.self, from: data)
                    DispatchQueue.main.async {
                        self.books = results.books
                    }
                }
                catch {
                    print(error)
                }
            }
        }.resume()
    }
}

struct BookListApi: Codable {
    var books: [Book]
}
