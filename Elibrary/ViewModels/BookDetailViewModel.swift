//
//  BookDetailViewModel.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 18.01.2023.
//

import SwiftUI

class BookDetailViewModel: ObservableObject {
    init() {}

    public func borrowBook(book: Book, user: UserModel) {
        let body = CirculationPost(book: book, borrower: user)
        Networking.shared.sendPostRequest(to: "/api/v1/circulation", body: body.encoded(), then: { (result) in

            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .showAlert,
                                                    object: AlertData(title: Text("Info"),
                                                                      message: Text("Kniha byla vypůjčena"),
                                                                      dismissButton: .default(Text("OK")) {}))
                }
            case .failure(_):
                break
            }
        })

    }
}
