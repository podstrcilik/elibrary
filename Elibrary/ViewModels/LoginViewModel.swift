//
//  LoginViewModel.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 23.11.2022.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var password: String = ""
    @State var loggedUser: UserModelNetwork?
    @Published var isPresented = false
    @Published var user = LoggedUser(apiKey: "", id: "", firstName: "", lastName: "", birthNumber: "", username: "", role: "", street: "", city: "", postCode: "")


    // MARK: - Properties
    func logIn() {
        let test = LoginNetworkModel(username: name, password: password)
//                let test = LoginNetworkModel(username: "kubrt", password: "asd")

        Networking.shared.sendPostRequest(to: "/api/v1/auth/login", body: test.encoded(), then: { (result) in
            if case .success(let succesData) = result {
                do {
                    let results = try JSONDecoder().decode(GenericNetworkLayer<UserModelNetwork>.self, from: succesData)
                    self.loggedUser = results.data
                    self.user.apiKey = results.data.apiKey
                    self.user.id = results.data.id
                    self.user.firstName = results.data.firstName
                    self.user.lastName = results.data.lastName
                    self.user.birthNumber = results.data.birthNumber
                    self.user.username = results.data.username
                    self.user.role = results.data.role
                    self.user.city = results.data.address.city
                    self.user.street = results.data.address.street
                    self.user.postCode = results.data.address.postcode
                    Networking.shared.apiKey = results.data.apiKey
                    DispatchQueue.main.async {
                        self.isPresented = true
                    }
                }
                catch {
                    print(error)
                }
            }
        })
    }
}
