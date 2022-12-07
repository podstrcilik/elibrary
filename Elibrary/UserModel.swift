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
    var adress: String
    var email: String
}


extension UserModel {
    static let sampleUser = UserModel(id: UUID(), username: "pavel12345", name: "Pavel Odstrčilík", personalIdentificationNumber: "880230/4112", adress: "Záhlinice 5",email: "email@seznam.cz")
}
