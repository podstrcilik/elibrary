//
//  BookDetailViewModel.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 18.01.2023.
//

import SwiftUI

struct CirculationPost: Codable {
    var book: Book
    var borrower: UserModel
}


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
//                    DispatchQueue.main.async {
//                        NotificationCenter.default.post(name: .showAlert,
//                                                        object: AlertData(title: Text("Error"),
//                                                                          message: Text(messages.joined()),
//                                                                          dismissButton: .default(Text("OK")) {
//                        }))
//                    }
                print("a")
            case .failure(_):
                break
            }
        })

    }
}
