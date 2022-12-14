//
//  AccountView.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 30.11.2022.
//

import SwiftUI

struct AccountView: View {
    @State var user: UserModel
    @State private var showEditModal = false

    var body: some View {
        Form {
            VStack(alignment: .leading) {
                userView
                Divider()
                Text("Adresa")
                TextField("", text: $user.address)
                Divider()
                Text("Rodné číslo")
                TextField("", text: $user.personalIdentificationNumber)

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
        .sheet(isPresented: $showEditModal) {
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
            Text("Jméno")
            TextField("", text: $user.name)
            Divider()
            Text("Uživatelské jméno")
            TextField("", text: $user.username)
        }
    }

    var emailView: some View {
        Group {
            Text("Email")
            TextField("", text: $user.email)
            Divider()
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(user: UserModel.sampleUser)
    }
}
