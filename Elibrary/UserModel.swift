//
//  UserModel.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 30.11.2022.
//

import SwiftUI

//jméno, příjmení, rodné číslo, adresu, uživatelské jméno a heslo
struct UserModel: Identifiable, Codable {
    var id: String
    var firstName: String
    var lastName: String
    var birthNumber: String
    var username: String
    var role: String
    var password: String? = nil
    var isApproved: Bool
    var isBanned: Bool
    var address: Address
}


extension UserModel {
    static let sampleUser = UserModel(id: "1", firstName: "2", lastName: "3", birthNumber: "4", username: "5", role: "6", isApproved: true, isBanned: false, address: Address(street: "", city: "", postcode: ""))
    
    static let sampleData = [
        UserModel(id: "1", firstName: "2", lastName: "3", birthNumber: "4", username: "5", role: "6", isApproved: true, isBanned: false, address: Address(street: "", city: "", postcode: ""))
    ]
}

extension UserModel {
    var isValid: Bool {
        return !firstName.isEmpty && !lastName.isEmpty && !birthNumber.isEmpty
    }
}



struct UserModelNetwork: Codable, Identifiable {
    var apiKey: String
    var id: String
    var firstName: String
    var lastName: String
    var birthNumber: String
    var username: String
    var role: String
    var password: String? = nil
    var isApproved: Bool
    var isBanned: Bool
    var address: Address

}


class LoggedUser: ObservableObject {
    @Published var apiKey: String
    @Published var id: String
    @Published var firstName: String
    @Published var lastName: String
    @Published var birthNumber: String
    @Published var username: String
    @Published var role: String
    @Published var password: String? = nil
    @Published var street: String
    @Published var city: String
    @Published var postCode: String

    var isLibrarian: Bool {
        return role == "Librarian"
    }

    init(apiKey: String, id: String, firstName: String, lastName: String, birthNumber: String, username: String, role: String, password: String? = nil, street: String, city: String, postCode: String) {
        self.apiKey = apiKey
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.birthNumber = birthNumber
        self.username = username
        self.role = role
        self.password = password
        self.street = street
        self.city = city
        self.postCode = postCode
    }
}

