//
//  NewBookView.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 07.12.2022.
//

import SwiftUI
import PhotosUI

struct NewBookView: View {
    @Binding var showModal: Bool
    @State var book: Book
    @State var editMode: Bool = false

    @StateObject var viewModel = NewBookViewModel()
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedItemTitle: PhotosPickerItem? = nil
//    @State private var selectedImageData: Data? = nil
//    @State private var selectedImageDataTitle: Data? = nil

    var body: some View {
        VStack {
            Form {
                VStack(alignment: .leading) {
                    baseView
                    Divider()
                    imageView
                    Divider()
//                    imageView
//                    imageTitleView
                }
                VStack(alignment: .leading) {
                    imageTitleView
                }
            }
            Button(action: {
                viewModel.uploadImage()

//                let uiImage = UIImage(data: viewModel.selectedImageData)
                Networking.shared.uploadImage(paramName: "image", fileName: "pepedas", image: UIImage(data: viewModel.selectedImageData!)!)
                self.showModal.toggle()
            }) {
                Text(editMode ? "Upravit" : "Přidat")
                    .frame(maxWidth: .infinity, maxHeight: 50)
            }
            .buttonStyle(ConfirmButtonStyle())
//            .disabled(!book.isValid)
        }
        .background(Color(.systemGray6))
    }

    var baseView: some View {
        Group {
            Text("Název knihy")
            TextField("Název", text: $viewModel.title)
            Text("Autor knihy")
            TextField("Autor", text: $viewModel.author)
            Text("Počet stránek")
            TextField("Stránky", value: $viewModel.numberOfPages, formatter: NumberFormatter())
                .keyboardType(.numberPad)
            Text("Rok vydání")
            TextField("Rok", value: $viewModel.yearOfPublication, formatter: NumberFormatter())
                .keyboardType(.numberPad)
            Text("Dostupné množství")
            TextField("Množství", value: $viewModel.numberOfLicences, formatter: NumberFormatter())
                .keyboardType(.numberPad)
        }
    }

    var imageView: some View {
        Group {
            Text("Obal")
            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()) {
                    Text("Vybrat obrázek")
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
                        // Retrieve selected asset in the form of Data
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            viewModel.selectedImageData = data
                        }
                    }
                }

            if let img = viewModel.selectedImageData,
               let uiImage = UIImage(data: img) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
        }
    }

    var imageTitleView: some View {
        Group {
            Text("Titulní stránka")
            PhotosPicker(
                selection: $selectedItemTitle,
                matching: .images,
                photoLibrary: .shared()) {
                    Text("Vybrat obrázek")
                }
                .onChange(of: selectedItemTitle) { newItem in
                    Task {
                        // Retrieve selected asset in the form of Data
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            viewModel.selectedImageDataTitle = data
                        }
                    }
                }

            if let img = viewModel.selectedImageDataTitle,
               let uiImage = UIImage(data: img) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
        }
    }


}

struct NewBookView_Previews: PreviewProvider {
    static var previews: some View {
        NewBookView(showModal: .constant(true), book: Book(id: "1", title: "", author: "", numberOfPages: 0, yearOfPublication: 2023, numberOfLicences: 0))
    }
}
