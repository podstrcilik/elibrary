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
                    Text("Adresa")
                    TextField("Adresa bydliště", text: $user.address)
                    Divider()
                    Text("Rodné číslo")
                    TextField("Rodné číslo", text: $user.personalIdentificationNumber)
                }
            }
            Button(action: {
                self.showModal.toggle()
            }) {
                Text("Uložit")
            }
            .buttonStyle(ConfirmButtonStyle())
        }
    }

    var userView: some View {
        Group {
            Text("Jméno")
            TextField("Jméno a příjmení", text: $user.name)
            Divider()
            Text("Uživatelské jméno")
            TextField("Uživatelské jméno", text: $user.username)
        }
    }

    var emailView: some View {
        Group {
            Text("Email")
            TextField("E-mailová adresa", text: $user.email)
            Divider()
        }
    }

}

struct EditAccountView_Previews: PreviewProvider {
    static var previews: some View {
        EditAccountView(user: UserModel.sampleUser, showModal: .constant(true))
    }
}
