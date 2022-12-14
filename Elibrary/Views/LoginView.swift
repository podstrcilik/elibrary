//
//  LoginView.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 23.11.2022.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @State private var isPresented = false
    
    @State var showRegistration = false;
    @State var username = "";
    @State var password = "";
    
    var body: some View {
        VStack{
            VStack {
                LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottom)
                    .mask(
                        VStack{
                            Image(systemName: "book.circle")
                                .resizable()
                                .frame(width: 180, height: 180).padding()
                            Text("Knihotéka").font(.title).bold()
                    
                        })
            }
            Spacer()
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Přihlašovací jméno")
                    TextField(
                        "Jméno",
                        text: $username
                    )
                }.padding()
                VStack(alignment: .leading) {
                    Text("Heslo")
                    SecureField(
                        "Heslo",
                        text: $password
                    )
                }.padding()
                Button(action: {
                    self.isPresented.toggle()
                }) {
                    Text("Přihlásit se")
                        .frame(maxWidth: .infinity, maxHeight: 50)
                }
                .buttonStyle(ConfirmButtonStyle()).padding(-15)
                
            }
            .padding(.bottom)
            .fullScreenCover(isPresented: $isPresented, content: MainTabView.init)
            HStack(alignment: .center){
                Text("Nemáš ještě účet?").opacity(0.6)
                Button(action: { showRegistration.toggle()}) {
                    Text("Registrovat se")
                }
            }
        }.padding()
            .sheet(isPresented: $showRegistration) {
                NavigationView {
                    EditAccountView(user: UserModel(
                        id: UUID(), username: "", name: "", personalIdentificationNumber: "", address: "", email: ""), showModal: self.$showRegistration)
                    .navigationTitle("Založ si účet")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Zavřít") {
                                showRegistration.toggle()
                            }
                        }
                    }
                }
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
