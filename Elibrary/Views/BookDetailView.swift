//
//  BookDetailView.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 07.12.2022.
//

import SwiftUI

struct BookDetailView: View {
    @State var book: Book = Book(id: "", title: "", author: "", numberOfPages: 0, yearOfPublication: 0, numberOfLicences: 0)
    @State private var showNewBookModal = false
    @State var isPresenting = false
    @EnvironmentObject var loggedUser: LoggedUser
    @StateObject var viewModel = BookDetailViewModel()


    var body: some View {
        VStack(alignment: .leading) {
            Text(book.title)
                .font(.title)
                .foregroundColor(.primary)
            HStack {
                CustomImageView(urlString: "https://bookify-backend.dev07.b2a.cz/api/v1/file/\(book.coverFileId ?? "0")/raw")
                VStack(alignment: .leading) {
                    Text("Autor: \(book.author)")
                    Text("Rok vydání: \(String(describing: book.yearOfPublication))")
                    Text("Počet stran: \(book.numberOfLicences)")
                    Text("Dostupné množství \(book.numberOfLicences)")
                }
            }
            HStack(alignment: .center) {
                Spacer()
                CustomImageView(urlString: "https://bookify-backend.dev07.b2a.cz/api/v1/file/\(book.frontPageFileId ?? "0")/raw")
                Spacer()
//                    .frame(width: 300)
            }
            Spacer()
            if loggedUser.isLibrarian {
                Button(action: {
                    isPresenting = true

                }) {
                    Text("Přiřadit")
                        .frame(maxWidth: .infinity, maxHeight: 50)
                }
                .background(.orange)
                .foregroundColor(.white)
                .cornerRadius(5)
            }
            Button(action: {
                let user = UserModel(id: loggedUser.id, firstName: loggedUser.firstName, lastName: loggedUser.lastName, birthNumber: loggedUser.birthNumber, username: loggedUser.username, role: loggedUser.role, isApproved: true, isBanned: false, address: Address(street: loggedUser.street, city: loggedUser.city, postcode: loggedUser.postCode))

                viewModel.borrowBook(book: book, user: user)
            }) {
                Text("Vypůjčit")
                    .frame(maxWidth: .infinity, maxHeight: 50)
            }
            .background(book.numberOfLicences > 0 ? .blue : .gray)
            .foregroundColor(.white)
            .cornerRadius(5)
            .disabled(book.numberOfLicences == 0)

        }.toolbar {
            if loggedUser.isLibrarian {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        showNewBookModal.toggle()
                    }) {
                        Text("Edit")
                    }
                    
                }
            }
        }
        .padding()
        .navigationTitle("Kniha")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showNewBookModal, onDismiss: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

                Networking.shared.getRequest(to: "/api/v1/book/\(book.id)", then: { (result) in
                    if case .success(let succesData) = result {
                        do {
                            let results = try JSONDecoder().decode(GenericNetworkLayer<Book>.self, from: succesData)
                            DispatchQueue.main.async {
                                self.book = results.data
                            }
                        }
                        catch {
                            print(error)
                        }
                    }
                })
            }

        }) {
            NavigationView {
                NewBookView(showModal: self.$showNewBookModal, book: book, editMode: true)
                    .navigationTitle("Editace knihy")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Zavřít") {
                                showNewBookModal.toggle()
                            }
                        }
                    }
            }
        }
        .sheet(isPresented: $isPresenting) {
            NavigationView {
                AssingListView(book: book)
                    .navigationTitle("Přiřadit uživateli")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Zavřít") {
                                isPresenting.toggle()
                            }
                        }
                    }
            }
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(book: Book.sampleData[1])
    }
}
