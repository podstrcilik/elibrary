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

extension Book {
    static let sampleData = [
        Book(
            title: "Osudné svědectví",
            author: "Bryndza Robert",
            pageCount: 220,
            yearPublished: "2022",
            availableCount: 10
        ),
        Book(
            title: "Martin Šonka: Můj let do nebes",
            author: "Sára Robert",
            pageCount: 220,
            yearPublished: "2022",
            availableCount: 10
        ),
        Book(
            title: "Kosti v srdci",
            author: "Hoover Colleen",
            pageCount: 220,
            yearPublished: "2022",
            availableCount: 10
        ),
        Book(
            title: "Hrad ve Skotsku",
            author: "Caplin Julie",
            pageCount: 220,
            yearPublished: "2022",
            availableCount: 0
        ),
        Book(
            title: "Lucemburská epopej I - Král cizinec (1309-1333)",
            author: "Vondruška Vlastimil",
            pageCount: 220,
            yearPublished: "2022",
            availableCount: 10
        ),
        Book(
            title: "Osudné svědectví",
            author: "Bryndza Robert",
            pageCount: 220,
            yearPublished: "2022",
            availableCount: 10
        ),
        Book(
            title: "Martin Šonka: Můj let do nebes",
            author: "Sára Robert",
            pageCount: 220,
            yearPublished: "2022",
            availableCount: 10
        ),
        Book(
            title: "Kosti v srdci",
            author: "Hoover Colleen",
            pageCount: 220,
            yearPublished: "2022",
            availableCount: 10
        ),
        Book(
            title: "Hrad ve Skotsku",
            author: "Caplin Julie",
            pageCount: 220,
            yearPublished: "2022",
            availableCount: 0
        ),
        Book(
            title: "Lucemburská epopej I - Král cizinec (1309-1333)",
            author: "Vondruška Vlastimil",
            pageCount: 220,
            yearPublished: "2022",
            availableCount: 10
        ),
    ]
}
