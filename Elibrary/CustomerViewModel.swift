//
//  CustomerViewModel.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 14.12.2022.
//

import Foundation

class CustomerViewModel: ObservableObject {
    @Published var customers: [UserModel] = []

    init() {}

    public func fetch() {
        Networking.shared.getRequest(to: "/api/v1/user", then: { (result) in
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
}

struct CustomerListApi: Codable {
    var customers: [UserModel]
}
