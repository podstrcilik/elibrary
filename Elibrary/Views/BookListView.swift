//
//  BookListView.swift
//  Elibrary
//
//  Created by Kristýna Tomanová on 30.11.2022.
//

import SwiftUI

struct BookListView: View {
    @State private var searchText = ""
    @State var books: [Book]
    
    func add() -> Void {}
    
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
            .navigationTitle("Knihotéka")
            .toolbar {
                
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    EditButton()
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
        BookListView(books: Book.sampleData)
    }
}
