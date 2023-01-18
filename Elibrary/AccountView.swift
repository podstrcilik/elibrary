//
//  AccountView.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 30.11.2022.
//

import SwiftUI

struct AccountView: View {
    @State var user: UserModel// = UserModel(id: "", firstName: "", lastName: "", birthNumber: "", username: "", role: "", isApproved: true, isBanned: false, address: Address(street: "", city: "", postcode: ""))
    @State private var showEditModal = false

    var body: some View {
        Form {
            VStack(alignment: .leading) {
                    userView
                    addressView
                    Divider()
                    Text("Rodné číslo")
                TextField("Rodné číslo", text: $user.birthNumber)
            }.allowsHitTesting(false)
        }
        .navigationTitle("Účet")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    showEditModal.toggle()
                }) {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $showEditModal, onDismiss: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                Networking.shared.getRequest(to: "/api/v1/user/\(user.id)", then: { (result) in
                    if case .success(let succesData) = result {
                        do {
                            let results = try JSONDecoder().decode(GenericNetworkLayer<UserModel>.self, from: succesData)
                            DispatchQueue.main.async {
                                self.user = results.data
                            }
                        }
                        catch {
                            print(error)
                        }
                    }
                })
            }
        }
        ) {
            NavigationView {
                EditAccountView(user: user, showModal: $showEditModal)
                .navigationTitle("Editace účtu")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Zavřít") {
                                showEditModal.toggle()
                            }
                        }
                    }
            }
        }

    }

    var userView: some View {
        Group {
            Text("Uživatelské jméno")
            TextField("Uživatelské jméno", text: $user.username)
            Divider()
            Text("Jméno")
            TextField("Jméno", text: $user.firstName)
            Divider()
            Text("Příjmení")
            TextField("Příjmení", text: $user.lastName)
//            Text("Heslo")
//            SecureField(
//                "Heslo",
//                text: $user.password)
        }
    }

    var addressView: some View {
        Group {
            Divider()
            Text("Ulice")
            TextField("Ulice", text: $user.address.street)
            Divider()
            Text("Město")
            TextField("Město", text: $user.address.city)
            Divider()
            Text("PSČ")
            TextField("PSČ", text: $user.address.postcode)
        }
    }

}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(user: UserModel.sampleUser)
    }
}
