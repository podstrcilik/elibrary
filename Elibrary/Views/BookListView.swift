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
    @State var selectedIndex: String?
    @EnvironmentObject var loggedUser: LoggedUser

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
                        if loggedUser.isLibrarian {
                            Button("Delete") {
                                viewModel.deleteBook(id: book.id)
                            }.tint(.red)
                        }
                    }
                }
            }
            .refreshable {
                viewModel.fetchBooks()
            }
            .searchable(text: $searchText, prompt: "Vyhledej literaturu")
            .onChange(of: searchText) { searchText in
                viewModel.fetchBooks(search: searchText)
            }

            .navigationTitle("Knihotéka")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if loggedUser.isLibrarian {
                        Button(action: {
                            showNewBookModal.toggle()
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                    Menu(content: {
                        Section("Řadit podle") {
                            Button(action: {
                                //                            showNewBookModal.toggle()
                                viewModel.orderKey = "title"
                                viewModel.fetchBooks()
                                selectedIndex = viewModel.orderKey
                            }) {
                                if selectedIndex == "title" {
                                    Label("Název", systemImage: "checkmark")
                                } else {
                                    Text("Název")
                                }
                            }
                            Button(action: {
                                viewModel.orderKey = "yearOfPublication"
                                viewModel.fetchBooks()
                                selectedIndex = viewModel.orderKey
                            }) {
                                if selectedIndex == "yearOfPublication" {
                                    Label("Rok", systemImage: "checkmark")
                                } else {
                                    Text("Rok")
                                }
                            }
                            Button(action: {
                                viewModel.orderKey = "author"
                                viewModel.fetchBooks()
                                selectedIndex = viewModel.orderKey
                            }) {
                                if selectedIndex == "author" {
                                    Label("Autor", systemImage: "checkmark")
                                } else {
                                    Text("Autor")
                                }
                            }
                        }
                    }, label: { Image(systemName: "ellipsis.circle") })
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
