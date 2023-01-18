//
//  AssignViewModel.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 18.01.2023.
//

import Foundation

class AssignViewModel: ObservableObject {
    @Published var customers: [UserModel] = []

    init() {}

    public func fetch(search: String? = nil) {
        var url = "/api/v1/user"
        if let search {
            url += "?search=\(search)"
        }

        Networking.shared.getRequest(to: url, then: { (result) in
            if case .success(let succesData) = result {
                do {
                    let results = try JSONDecoder().decode(GenericCollectionNetworkLayer<UserModel>.self, from: succesData)
                    DispatchQueue.main.async {
                        self.customers = results.data
                    }
                }
                catch {
                    print(error)
                }
            }
        })
    }

    public func assignBook(book: Book, user: UserModel) {
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
