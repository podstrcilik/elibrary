//
//  NewBookViewModel.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 15.01.2023.
//

import Foundation
import SwiftUI

class NewBookViewModel: ObservableObject {
    @Published var bookId: String = ""
    @Published var title: String = ""
    @Published var author: String = ""
    @Published var numberOfPages: Int = 0
    @Published var yearOfPublication: Int = 0
    @Published var numberOfLicences: Int = 0
    @Published var selectedImageData: Data? = nil
    @Published var selectedImageDataTitle: Data? = nil
    @Published var coverImage: UIImage? = nil
    @Published var frontPageImage: UIImage? = nil
    var frontPageFileId: String?
    var coverFileId: String?
    var editMode = false


    func uploadImage() {

        if let coverImage {
            Networking.shared.uploadImage(paramName: "image", fileName: "dsajkdas", image: coverImage,handler: { (result) in
                if case .success(let succesData) = result {
                    let jsonData = try? JSONSerialization.jsonObject(with: succesData, options: .allowFragments)
                    if let json = jsonData as? [String: Any] {
                        self.coverFileId = (json["data"] as? [String:Any])?["fileId"] as? String
                        self.uploadFrontPageImage()
                    }


                }
            })
        } else {
            self.uploadFrontPageImage()
        }
    }

    func uploadFrontPageImage() {
        if let frontPageImage {

            Networking.shared.uploadImage(paramName: "image", fileName: "dsajkdas", image: frontPageImage,handler: { (result) in
                if case .success(let succesData) = result {
                    let jsonData = try? JSONSerialization.jsonObject(with: succesData, options: .allowFragments)
                    if let json = jsonData as? [String: Any] {
                        self.frontPageFileId = (json["data"] as? [String:Any])?["fileId"] as? String
                        self.createBook()
                    }
                }
            })
        } else {
            createBook()
        }
    }

    func createBook() {
        let book = Book(id: bookId, title: title, author: author, numberOfPages: numberOfPages, yearOfPublication: yearOfPublication, numberOfLicences: numberOfLicences, frontPageFileId: frontPageFileId, coverFileId: coverFileId)

        if !editMode {
            Networking.shared.sendPostRequest(to: "/api/v1/book", body: book.encoded(), then: { (result) in

                switch result {
                case .success(_):
                    print("Ok")
                case .failure(MessageError.error(messages: _)):
                    break
                case .failure(_):
                    break
                }
            })
        } else {
            Networking.shared.sendPutRequest(to: "/api/v1/book/\(bookId)", body: book.encoded(), then: { (result) in
                if case .success(_) = result {
                }
                
            })
        }
    }

}
