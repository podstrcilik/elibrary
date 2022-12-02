//
//  Book.swift
//  Elibrary
//
//  Created by Kristýna Tomanová on 23.11.2022.
//

import Foundation

struct Book: Identifiable {
    var id = UUID()
    let title: String
    let author: String
    let pageCount: Int
    let yearPublished: String
    let availableCount: Int
}
