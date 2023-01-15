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
    var isApproved: Bool
    var isBanned: Bool
    var address: Address
//    var name: String
//    var personalIdentificationNumber: String
//    var address: String
//    var email: String
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
    var id: String
    var firstName: String
    var lastName: String
    var apiKey: String
}


class LoggedUser: ObservableObject {
    @Published var apiKey: String
    init(apiKey: String) {
        self.apiKey = apiKey
    }
}

