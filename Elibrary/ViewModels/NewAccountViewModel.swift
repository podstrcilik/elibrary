//
//  NewAccountViewModel.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 16.01.2023.
//

import Foundation
import SwiftUI

class NewAccountViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var birthNumber: String = ""
    @Published var username: String = ""
    @Published var role: String = ""
    @Published var street: String = ""
    @Published var city: String = ""
    @Published var postcode: String = ""
    @Published var password: String = ""
    var isApproved: Bool = false
    var isBanned: Bool = false
    var address: Address = Address(street: "", city: "", postcode: "")
    var editMode = false
    var isRegistration = false

    func createUser() {
        var user = UserModel(id: id, firstName: firstName, lastName: lastName, birthNumber: birthNumber, username: username, role: role, password: password, isApproved: false, isBanned: false, address: Address(street: street, city: city, postcode: postcode))

        if isRegistration {
            Networking.shared.sendPostRequest(to: "/api/v1/auth/register", body: user.encoded(), then: { (result) in
                if case .success(_) = result {
                        NotificationCenter.default.post(name: .showAlert,
                                                        object: AlertData(title: Text("Info"),
                                                                          message: Text("Ůčet byl zaregistrován"),
                                                                          dismissButton: .default(Text("OK")) {
                        }))
                }
            })

            return
        }

        if !editMode {
            Networking.shared.sendPostRequest(to: "/api/v1/user", body: user.encoded(), then: { (result) in
                if case .success(_) = result {
                }
            })
        } else {
            if password.isEmpty {
                user.password = nil
            }
            let url = role == "Librarian" ? "/api/v1/user/\(id)" : "/api/v1/auth/profile"
            Networking.shared.sendPutRequest(to: url, body: user.encoded(), then: { (result) in
                if case .success(_) = result {
                }
            })

        }
    }

}
