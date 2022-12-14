//
//  BookDetailView.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 07.12.2022.
//

import SwiftUI

struct BookDetailView: View {
    var book: Book
    @State private var showNewBookModal = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(book.title)
                .font(.title)
                .foregroundColor(.primary)
            HStack {
                Image("kostivsrdci")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                VStack(alignment: .leading) {
                    Text("Autor: \(book.author)")
                    Text("Rok vydání: \(book.yearPublished)")
                    Text("Počet stran: \(book.availableCount)")
                    Text("Dostupné množství \(book.availableCount)")
                }
            }
            Spacer()
            Button(action: {
                print("vypůjčit")
            }) {
                Text("Vypůjčit")
                    .frame(maxWidth: .infinity, maxHeight: 50)
            }
            .background(book.availableCount > 0 ? .blue : .gray)
            .foregroundColor(.white)
            .cornerRadius(5)
            .disabled(book.availableCount == 0)

        }.toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    showNewBookModal.toggle()
                }) {
                    Text("Edit")
                }
            }
        }
        .padding()
        .navigationTitle("Kniha")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showNewBookModal) {
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
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(book: Book.sampleData[1])
    }
}
