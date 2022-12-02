//
//  BookListView.swift
//  Elibrary
//
//  Created by Kristýna Tomanová on 30.11.2022.
//

import SwiftUI

struct BookListView: View {
    @State private var searchText = ""
    
    func add() -> Void {}
    
    var books = [
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
        )
    ]

    var body: some View {
        NavigationView {
            List(books) { book in
                BookListCellView(
                    title: book.title,
                    author: book.author,
                    pageCount: book.pageCount,
                    yearPublished: book.yearPublished,
                    availableCount: book.availableCount
                )
                
            }
            .searchable(
                text: $searchText,
                prompt: "Vyhledej literaturu"
            )
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItemGroup(placement: .principal) {
                    Text("Knihotéka").font(.headline)
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    AddButton(onAdd: add)
                }
            
                
            }
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
