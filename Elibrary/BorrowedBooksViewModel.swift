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
    var orderKey: String?

    init() {}

    public func fetchBooks(search: String? = nil) {


        var url = "/api/v1/circulation"

        if let search {
            url += "?search=\(search)"
        }

//        if let orderKey {
//            if search != nil {
//                url += "&"
//            } else {
//                url += "?"
//            }
//            url += "order[\(orderKey)]=DESC"
//        }

        Networking.shared.getRequest(to: url, then: { (result) in
            if case .success(let succesData) = result {
                do {
                    let results = try JSONDecoder().decode(GenericCollectionNetworkLayer<Circulation>.self, from: succesData)
                    DispatchQueue.main.async {
//                        self.books = results.data
                        self.activeCirculations = results.data
                        self.oldCirculations = results.data
                        print("a")
                    }
                }
                catch {
                    print(error)
                }
            }
        })
    }
}
