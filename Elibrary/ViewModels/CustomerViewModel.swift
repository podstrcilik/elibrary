//
//  CustomerViewModel.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 14.12.2022.
//

import Foundation

class CustomerViewModel: ObservableObject {
    @Published var customers: [UserModel] = []
    var orderKey: String?

    init() {}

    public func fetch(search: String? = nil) {
        var url = "/api/v1/user"
        if let search {
            url += "?search=\(search)"
            if search.count <= 2, search.count != 0 {
                return
            }
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

    func makeBanRequest(userId: String) {
        Networking.shared.sendPutRequest(to: "/api/v1/user/\(userId)/ban", body: nil, then: { (result) in
            if case .success(_) = result {
                DispatchQueue.main.async {
                    self.customers = []
                    self.fetch()
                }
            }
        })
    }

    func makeApproveRequest(userId: String) {
        Networking.shared.sendPutRequest(to: "/api/v1/user/\(userId)/approve", body: nil, then: { (result) in
            if case .success(_) = result {
                DispatchQueue.main.async {
                    self.customers = []
                    self.fetch()
                }
            }
        })
    }

}
