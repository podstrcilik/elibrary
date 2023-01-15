//
//  NewBookViewModel.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 15.01.2023.
//

import Foundation
import SwiftUI

class NewBookViewModel: ObservableObject {
//    @Published var book: Book = Book(id: "", title: "", author: "", numberOfPages: 0, yearOfPublication: 0, numberOfLicences: 0)

    @Published var title: String = ""
    @Published var author: String = ""
    @Published var numberOfPages: Int = 0
    @Published var yearOfPublication: Int = 0
    @Published var numberOfLicences: Int = 0
    @Published var selectedImageData: Data? = nil
    @Published var selectedImageDataTitle: Data? = nil

    func uploadImage() {

        guard let selectedImageData else {
            return
        }
//        Networking.shared.sendPostRequest(to: "/api/v1/file/upload", body: selectedImageData, then: { (result) in
//            if case .success(let succesData) = result {
//                print("\(succesData.prettyPrintedJSONString) unread messages.")
//                do {
////                    let results = try JSONDecoder().decode(GenericNetworkLayer<UserModelNetwork>.self, from: succesData)
////                    self.loggedUser = results.data
////                    self.user.apiKey = results.data.apiKey
////                    Networking.shared.apiKey = results.data.apiKey
////                    self.isPresented = true // ??
//                    print("a")
//                }
//                catch {
//                    print(error)
//                }
//
//
//            }
//
////            print(result)
//        })
//        Networking.shared.

//        Networking.shared.uploadImageP(to: "/api/v1/file/upload", body: selectedImageData, then:  { (result) in
//            if case .success(let succesData) = result {
//                print("aaa")
//            }
//        })
        print("a")
    }

}
