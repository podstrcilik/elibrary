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
    @State private var showNewBookModal = false
    @StateObject var viewModel = BookListViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.books) { book in
                    NavigationLink(destination: BookDetailView(book: book)) {
                        BookListCellView(
                            title: book.title,
                            author: book.author,
                            pageCount: book.numberOfPages,
                            yearPublished:  "\(book.yearOfPublication)",
                            availableCount: book.numberOfLicences
                        )
                    }.swipeActions() {
                        Button("Delete") {
                            viewModel.books.removeAll(where: { $0.id == book.id})
                        }.tint(.red)
                        Button("Přidělit") {
                            
                        }.tint(.blue)
                    }
                }
            }
            .refreshable {
                viewModel.fetchBooks()
            }
            .searchable(
                text: $searchText,
                prompt: "Vyhledej literaturu"
            )
            .navigationTitle("Knihotéka")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        showNewBookModal.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .onAppear(perform: {
            viewModel.fetchBooks()
        })
        .sheet(isPresented: $showNewBookModal) {
            NavigationView {
                NewBookView(showModal: self.$showNewBookModal, book: Book(id: "999999",title: "", author: "", numberOfPages: 0, yearOfPublication: 2023, numberOfLicences: 0))
                    .navigationTitle("Přidání knihy")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Zavřít") {
                                showNewBookModal.toggle()
                            }
                        }
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
