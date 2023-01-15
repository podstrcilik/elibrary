//
//  LoginViewModel.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 23.11.2022.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var password: String = ""
    @State var loggedUser: UserModelNetwork?
    @Published var isPresented = false
    @Published var user = LoggedUser(apiKey: "")


    // MARK: - Properties
    func logIn() {
//        let test = LoginNetworkModel(username: name, password: password)
        let test = LoginNetworkModel(username: "kubrt", password: "asd")

        _ = Networking.shared.sendPostRequest(to: "/api/v1/auth/login", body: test.encoded(), then: { (result) in
            if case .success(let succesData) = result {
                print("\(succesData.prettyPrintedJSONString) unread messages.")
                do {
                    let results = try JSONDecoder().decode(GenericNetworkLayer<UserModelNetwork>.self, from: succesData)
                    self.loggedUser = results.data
                    self.user.apiKey = results.data.apiKey
                    Networking.shared.apiKey = results.data.apiKey
                    self.isPresented = true // ??
                    print("a")
                }
                catch {
                    print(error)
                }


            }

//            print(result)
        })
        print("a")
    }
}


extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
