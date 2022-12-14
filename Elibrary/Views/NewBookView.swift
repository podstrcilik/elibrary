//
//  NewBookView.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 07.12.2022.
//

import SwiftUI

struct NewBookView: View {
    @Binding var showModal: Bool
    @State var book: Book
    @State var editMode: Bool = false

    var body: some View {
        VStack {
            Form {
                VStack(alignment: .leading) {
                    Text("Název knihy")
                    TextField("Název", text: $book.title)
                    Text("Autor knihy")
                    TextField("Autor", text: $book.author)
                    Text("Počet stránek")
                    TextField("Stránky", value: $book.pageCount, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                    Text("Rok vydání")
                    TextField("Rok", text: $book.yearPublished)
                        .keyboardType(.numberPad)
                    Text("Dostupné množství")
                    TextField("Stránky", value: $book.availableCount, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
            }
            Button(action: {
                self.showModal.toggle()
            }) {
                Text(editMode ? "Upravit" : "Přidat")
                    .frame(maxWidth: .infinity, maxHeight: 50)
            }
            .buttonStyle(ConfirmButtonStyle())
        }
        .background(Color(.systemGray6))
    }
}

struct NewBookView_Previews: PreviewProvider {
    static var previews: some View {
        NewBookView(showModal: .constant(true), book: Book(title: "", author: "", pageCount: 0, yearPublished: "2023", availableCount: 0))
    }
}
