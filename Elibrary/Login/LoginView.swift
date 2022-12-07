//
//  LoginView.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 23.11.2022.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Text("Přihlašovací jméno")
                .font(.title)
            TextField(
                "Jméno",
                text: viewModel.$name
            )
                .frame(height: 40)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.blue, style: StrokeStyle(lineWidth: 2.0)))
                .disableAutocorrection(true)
            Text("Heslo")
                .font(.title)
            SecureField(
                "Heslo",
                text: viewModel.$password
            )
                .frame(height: 40)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.blue, style: StrokeStyle(lineWidth: 2.0)))
            Spacer()
            Button("Přihlasit se") {
                print("test")
//                isOrange.toggle()
            }
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(5)


//            Button(action: {
////                performLogin()
//            }) {
//                Text(isRegistration == true ? "Registrovat se" : "Přihlásit se")
//                    .frame(maxWidth: .infinity, maxHeight: 50)
//            }
//            .background(Color.blue)
//            .foregroundColor(Color.white)
//            .cornerRadius(5)
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
