//
//  LoginModel.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 15.01.2023.
//

import Foundation

struct LoginNetworkModel: Encodable {
    var username: String
    var password: String
}

extension Encodable {
    func encoded() -> Data {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            print("error")
            return Data()
        }
    }
}

