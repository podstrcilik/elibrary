//
//  BorrowedBooksListView.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 18.01.2023.
//

import SwiftUI

struct BorrowedBooksListView: View {
    @State private var searchText = ""
    @State var books: [Book]
    //    @State var circulations: [Circulation]
    @State private var showNewBookModal = false
    @StateObject var viewModel = BorrowedBooksViewModel()
    @State var selectedIndex: String?
    @EnvironmentObject var loggedUser: LoggedUser

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Aktuálně zapůjčené")) {
                    ForEach(viewModel.activeCirculations) { circulation in
                        let book = circulation.book
                        NavigationLink(destination: BookDetailView(book: book, readOnly: true)) {
                            BookListCellView(
                                title: book.title,
                                author: book.author,
                                pageCount: book.numberOfPages,
                                yearPublished:  "\(book.yearOfPublication)",
                                availableCount: book.numberOfLicences,
                                bottomTitle: "Vypůjčeno: \(circulation.borrowedAt?.date.dropLast(10) ?? "N/A")"
                            )
                        }.swipeActions() {
                                Button("Vrátit") {
                                    viewModel.returnBook(book: book)
//                                    viewModel.deleteBook(id: book.id)
                                }.tint(.green)

                        }
                    }
                    
                }
                Section(header: Text("Historie")) {
                    ForEach(viewModel.oldCirculations) { circulation in
                        let book = circulation.book
                        NavigationLink(destination: BookDetailView(book: book, readOnly: true)) {
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
                viewModel.fetchBooks(history: false)
                viewModel.fetchBooks(history: true)
            }
            .navigationTitle("Zapůjčené knihy")
        }
        .onAppear(perform: {
            viewModel.userId = loggedUser.id
            viewModel.fetchBooks(history: false)
            viewModel.fetchBooks(history: true)
        })
    }


}

struct BorrowedBooksListView_Previews: PreviewProvider {
    static var previews: some View {
        BorrowedBooksListView(books: [])
    }
}
