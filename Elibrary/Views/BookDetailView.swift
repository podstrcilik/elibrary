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
//                AsyncImage(url: URL(string: "https://example.com/icon.png"))
//                    .frame(width: 200, height: 200)

//                CustomImageView(url: URL(string: "https://example.com/icon.png")) { image in
//                    image.resizable()
//                } placeholder: {
//                    ProgressView()
//                }
//                .frame(width: 50, height: 50)

                CustomImageView(urlString: "https://bookify-backend.dev07.b2a.cz/api/v1/file/\(book.coverFileId ?? "0")/raw") // This is where you extract urlString from Model ( transaction.imageUrl)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 100, height: 100)


//                CustomAsyncImage(getImage: getImage) { image in
//                  image
//                    .resizable()
//                    .scaledToFit()
//                    .frame(maxWidth: .infinity)
//                } placeholder: {
//                    Text("PlaceHolder")
//                }


//                Image("kostivsrdci")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 100, height: 100)
                VStack(alignment: .leading) {
                    Text("Autor: \(book.author)")
                    Text("Rok vydání: \(String(describing: book.yearOfPublication))")
                    Text("Počet stran: \(book.numberOfLicences)")
                    Text("Dostupné množství \(book.numberOfLicences)")
                }
            }
            Spacer()
            Button(action: {
                print("vypůjčit")
            }) {
                Text("Vypůjčit")
                    .frame(maxWidth: .infinity, maxHeight: 50)
            }
            .background(book.numberOfLicences > 0 ? .blue : .gray)
            .foregroundColor(.white)
            .cornerRadius(5)
            .disabled(book.numberOfLicences == 0)

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
