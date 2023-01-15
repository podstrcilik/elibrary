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

    var body: some View {
        VStack {
            Form {
                VStack(alignment: .leading) {
                    userView
                    Divider()
                    emailView
                    Divider()
                    Text("Adresa")
//                    TextField("Adresa bydliště", text: $user.address)
                    Divider()
                    Text("Rodné číslo")
                    TextField("Rodné číslo", text: $user.birthNumber)
                }
            }
            Button(action: {
                self.showModal.toggle()
            }) {
                Text("Potvrdit")
            }
            .buttonStyle(ConfirmButtonStyle())
            .disabled(!user.isValid)
        }
    }

    var userView: some View {
        Group {
            Text("Uživatelské jméno")
            TextField("Uživatelské jméno", text: $user.username)
            Divider()
            Text("Jméno")
            TextField("Jméno a příjmení", text: $user.firstName)
        }
    }

    var emailView: some View {
        Group {
            Text("Email")
//            TextField("E-mailová adresa", text: $user.email)
        }
    }

}

struct EditAccountView_Previews: PreviewProvider {
    static var previews: some View {
        EditAccountView(user: UserModel.sampleUser, showModal: .constant(true))
    }
}
