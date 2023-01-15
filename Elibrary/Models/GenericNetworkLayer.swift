//
//  GenericNetworkLayer.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 15.01.2023.
//

import Foundation

struct GenericNetworkLayer<T: Codable>: Codable {
    var error: Bool
    var data: T
}

struct GenericCollectionNetworkLayer<T: Codable>: Codable {
    var error: Bool
    var data: [T]
}
