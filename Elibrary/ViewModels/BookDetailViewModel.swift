//
//  BookDetailViewModel.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 18.01.2023.
//

import SwiftUI

class BookDetailViewModel: ObservableObject {
//    @Published var books: [Book] = []
//    var orderKey: String?
//
    init() {}

    public func borrowBook(book: Book, user: UserModel) {
        let body = CirculationPost(book: book, borrower: user)
        Networking.shared.sendPostRequest(to: "/api/v1/circulation", body: body.encoded(), then: { (result) in

            switch result {
            case .success(let success):
                print("Ok")
            case .failure(MessageError.error(messages: let messages)):
                break
            case .failure(_):
                break
            }
        })

    }
}
