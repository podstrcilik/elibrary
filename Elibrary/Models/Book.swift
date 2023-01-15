//
//  Book.swift
//  Elibrary
//
//  Created by Kristýna Tomanová on 23.11.2022.
//

import Foundation

struct Book: Codable, Identifiable {
    var id: String
    var title: String
    var author: String
    var numberOfPages: Int
    var yearOfPublication: Int
    var numberOfLicences: Int
    var frontPageFileId: String?
    var coverFileId: String?
}

extension Book {
    static let sampleData = [
        Book(
            id: "1",
            title: "Osudné svědectví",
            author: "Bryndza Robert",
            numberOfPages: 220,
            yearOfPublication: 2022,
            numberOfLicences: 10
        ),
        Book(
            id: "2",
            title: "Martin Šonka: Můj let do nebes",
            author: "Sára Robert",
            numberOfPages: 220,
            yearOfPublication: 2022,
            numberOfLicences: 10
        ),
        Book(
            id: "3",
            title: "Kosti v srdci",
            author: "Hoover Colleen",
            numberOfPages: 220,
            yearOfPublication: 2022,
            numberOfLicences: 10
        ),
        Book(
            id: "4",
            title: "Hrad ve Skotsku",
            author: "Caplin Julie",
            numberOfPages: 220,
            yearOfPublication: 2022,
            numberOfLicences: 0
        ),
        Book(
            id: "5",
            title: "Lucemburská epopej I - Král cizinec (1309-1333)",
            author: "Vondruška Vlastimil",
            numberOfPages: 220,
            yearOfPublication: 2022,
            numberOfLicences: 10
        ),
        Book(
            id: "6",
            title: "Osudné svědectví",
            author: "Bryndza Robert",
            numberOfPages: 220,
            yearOfPublication: 2022,
            numberOfLicences: 10
        ),
        Book(
            id: "7",
            title: "Martin Šonka: Můj let do nebes",
            author: "Sára Robert",
            numberOfPages: 220,
            yearOfPublication: 2022,
            numberOfLicences: 10
        ),
        Book(
            id: "8",
            title: "Kosti v srdci",
            author: "Hoover Colleen",
            numberOfPages: 220,
            yearOfPublication: 2022,
            numberOfLicences: 10
        ),
        Book(
            id: "9",
            title: "Hrad ve Skotsku",
            author: "Caplin Julie",
            numberOfPages: 220,
            yearOfPublication: 2022,
            numberOfLicences: 0
        ),
        Book(
            id: "10",
            title: "Lucemburská epopej I - Král cizinec (1309-1333)",
            author: "Vondruška Vlastimil",
            numberOfPages: 220,
            yearOfPublication: 2022,
            numberOfLicences: 10
        ),
    ]
}

extension Book {
    var isValid: Bool {
        return !title.isEmpty && !author.isEmpty && numberOfPages > 0 && (yearOfPublication > 0)
    }
}
