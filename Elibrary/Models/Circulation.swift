//
//  Circulation.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 18.01.2023.
//

import SwiftUI

struct CirculationPost: Codable {
    var book: Book
    var borrower: UserModel
}

struct CirculationDate: Codable {
    var date: String
}

struct Circulation: Codable, Identifiable {
    var id: String
    var book: Book
    var borrower: UserModel
    var borrowedAt: CirculationDate? = nil
    var returnedAt: CirculationDate? = nil
    var expectedReturnAt: CirculationDate? = nil
}
