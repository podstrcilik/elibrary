//
//  EditAccountView.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 12.12.2022.
//

import SwiftUI

struct EditAccountView: View {
    @State var user: UserModel
    @Binding var showModal: Bool
    @StateObject var viewModel = NewAccountViewModel()
    var isRegistration = false


    var body: some View {
        VStack {
            Form {
                VStack(alignment: .leading) {
                    userView
                    addressView
                    Divider()
                    Text("Rodné číslo")
                    TextField("Rodné číslo", text: $viewModel.birthNumber)
                }
            }
            Button(action: {
                self.showModal.toggle()
                viewModel.isRegistration = isRegistration
                viewModel.createUser()
            }) {
                Text("Potvrdit")
            }
            .buttonStyle(ConfirmButtonStyle())
//            .disabled(!user.isValid)
            .onAppear(perform: {updateData()})
        }
    }

    var userView: some View {
        Group {
            Text("Uživatelské jméno")
            TextField("Uživatelské jméno", text: $viewModel.username)
            Divider()
            Text("Jméno")
            TextField("Jméno", text: $viewModel.firstName)
            Divider()
            Text("Příjmení")
            TextField("Příjmení", text: $viewModel.lastName)
            Text("Heslo")
            SecureField(
                "Heslo",
                text: $viewModel.password)
        }
    }

    var addressView: some View {
        Group {
            Divider()
            Text("Ulice")
            TextField("Ulice", text: $viewModel.street)
            Divider()
            Text("Město")
            TextField("Město", text: $viewModel.city)
            Divider()
            Text("PSČ")
            TextField("PSČ", text: $viewModel.postcode)
        }
    }

    func updateData() {
        if user.id.isEmpty {
            viewModel.editMode = false
            return
        }
        viewModel.editMode = true
        viewModel.id = user.id
        viewModel.firstName = user.firstName
        viewModel.lastName = user.lastName
        viewModel.birthNumber = user.birthNumber
        viewModel.username = user.username
        viewModel.role = user.role
        viewModel.street = user.address.street
        viewModel.city = user.address.city
        viewModel.postcode = user.address.postcode
    }

}

struct EditAccountView_Previews: PreviewProvider {
    static var previews: some View {
        EditAccountView(user: UserModel.sampleUser, showModal: .constant(true))
    }
}
