//
//  BorrowedBooksListView.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 18.01.2023.
//

import SwiftUI

struct CirculationDate: Codable {
    var date: String
}

struct Circulation: Codable, Identifiable {
    var id: String
    var book: Book
    var borrower: UserModel
    var borrowedAt: CirculationDate? = nil
    var returnedAt: CirculationDate? = nil
}

struct BorrowedBooksListView: View {
    @State private var searchText = ""
    @State var books: [Book]
    //    @State var circulations: [Circulation]
    @State private var showNewBookModal = false
    @StateObject var viewModel = BorrowedBooksViewModel()
    @State var selectedIndex: String?

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Aktuálně zapůjčené")) {
                    ForEach(viewModel.activeCirculations) { circulation in
                        let book = circulation.book
                        NavigationLink(destination: BookDetailView(book: book)) {
                            BookListCellView(
                                title: book.title,
                                author: book.author,
                                pageCount: book.numberOfPages,
                                yearPublished:  "\(book.yearOfPublication)",
                                availableCount: book.numberOfLicences,
                                bottomTitle: "Vypůjčeno: \(circulation.borrowedAt?.date.dropLast(10) ?? "N/A")"
                            )
                        }
                    }
                    
                }
                Section(header: Text("Historie")) {
                    ForEach(viewModel.oldCirculations) { circulation in
                        let book = circulation.book
                        NavigationLink(destination: BookDetailView(book: book)) {
                            BookListCellView(
                                title: book.title,
                                author: book.author,
                                pageCount: book.numberOfPages,
                                yearPublished:  "\(book.yearOfPublication)",
                                availableCount: book.numberOfLicences,
                                bottomTitle: "Vráceno: \(circulation.returnedAt?.date.dropLast(10) ?? "N/A")"
                            )
                        }
                    }

                }
            }
            .refreshable {
                viewModel.fetchBooks()
            }
            .navigationTitle("Zapůjčené knihy")
        }
        .onAppear(perform: {
            viewModel.fetchBooks()
        })
    }


}

struct BorrowedBooksListView_Previews: PreviewProvider {
    static var previews: some View {
        BorrowedBooksListView(books: [])
    }
}
