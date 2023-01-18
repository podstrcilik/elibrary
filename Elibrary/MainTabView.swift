//
//  MainTabView.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 30.11.2022.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var loggedUser: LoggedUser
    @State private var showAlert = false
    @State private var alertData = AlertData.empty

    var body: some View {
        TabView {
            BookListView(books: [])
                .tabItem {
                    Label("Knihotéka", systemImage: "books.vertical")
                }

            if loggedUser.isLibrarian {
                CustomerListView(customers: [])
                    .tabItem {
                        Label("Čtenáři", systemImage: "person.3.sequence.fill")
                    }
            }

            BorrowedBooksListView(books: [])
                .tabItem {
                    Label("Zapůjčené", systemImage: "books.vertical.circle")
                }

            NavigationView {
                AccountView(user: UserModel(id: loggedUser.id, firstName: loggedUser.firstName, lastName: loggedUser.lastName, birthNumber: loggedUser.birthNumber, username: loggedUser.username, role: loggedUser.role, isApproved: true, isBanned: false, address: Address(street: loggedUser.street, city: loggedUser.city, postcode: loggedUser.postCode)))
            }
            .tabItem {
                Label("Můj účet", systemImage: "person.crop.circle.fill")
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .showAlert)) { notif in
          if let data = notif.object as? AlertData {
            alertData = data
            showAlert = true
          }
        }
        .alert(isPresented: $showAlert) {
          Alert(title: alertData.title,
                message: alertData.message,
                dismissButton: alertData.dismissButton)
        }

    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}


struct BaseView: View {
    var body: some View {
        Text("aa")
    }
}
