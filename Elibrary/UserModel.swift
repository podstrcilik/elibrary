//
//  UserModel.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 30.11.2022.
//

import SwiftUI

//jméno, příjmení, rodné číslo, adresu, uživatelské jméno a heslo
struct UserModel: Identifiable, Codable {
    var id: UUID
    var username: String
    var name: String
    var personalIdentificationNumber: String
    var address: String
    var email: String
}


extension UserModel {
    static let sampleUser = UserModel(id: UUID(), username: "pavel12345", name: "Pavel Odstrčilík", personalIdentificationNumber: "880230/4112", address: "Záhlinice 5",email: "email@seznam.cz")
    
    static let sampleData = [
        UserModel(
            id: UUID(),
            username: "pavel12345",
            name: "Pavel Odstrčilík",
            personalIdentificationNumber: "880230/4112",
            address: "Záhlinice 5",
            email: "email@seznam.cz"
        ),
        UserModel(
            id: UUID(),
            username: "kristytoman",
            name: "Kristýna Tomanová",
            personalIdentificationNumber: "983274/5555",
            address: "Senička 50",
            email: "kristytoman@email.cz"
        ),
        UserModel(
            id: UUID(),
            username: "vasa1234",
            name: "Václav Toncer",
            personalIdentificationNumber: "9902836/6372",
            address: "TGM 222, Zlín",
            email: "vaclav@email.cz"
        ),

    ]
}
