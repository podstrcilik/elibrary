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
        guard let url = URL(string: "http://127.0.0.1:3001/customers") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(CustomerListApi.self, from: data)
                    DispatchQueue.main.async {
                        self.customers = results.customers
                    }
                }
                catch {
                    print(error)
                }
            }
        }.resume()
    }
}

struct CustomerListApi: Codable {
    var customers: [UserModel]
}
