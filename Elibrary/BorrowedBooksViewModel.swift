//
//  BorrowedBooksViewModel.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 18.01.2023.
//

import SwiftUI

class BorrowedBooksViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var activeCirculations: [Circulation] = []
    @Published var oldCirculations: [Circulation] = []
    var userId: String? = nil
    var orderKey: String?

    init() {}

    public func fetchBooks(history: Bool) {


        var url = "/api/v1/circulation?borrowerId=\(userId ?? "")"

        if history {
            url += "&returned=true"
        } else {
            url += "&returned=false"
        }


        Networking.shared.getRequest(to: url, then: { (result) in
            if case .success(let succesData) = result {
                do {
                    let results = try JSONDecoder().decode(GenericCollectionNetworkLayer<Circulation>.self, from: succesData)
                    DispatchQueue.main.async {
//                        self.books = results.data
                        if !history {
                            self.activeCirculations = results.data
                        } else {
                            self.oldCirculations = results.data
                        }
                        print("a")
                    }
                }
                catch {
                    print(error)
                }
            }
        })
    }

    public func returnBook(book: Book) {
        let url = "/api/v1/book/\(book.id)"
            Networking.shared.sendPutRequest(to: url, body: book.encoded(), then: { (result) in
            if case .success(let succesData) = result {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

                        self.activeCirculations = []
                        self.oldCirculations = []
                        self.fetchBooks(history: true)
                        self.fetchBooks(history: false)

                }
            }
        })
    }
}
