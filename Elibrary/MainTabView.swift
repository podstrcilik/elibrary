//
//  MainTabView.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 30.11.2022.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var loggedUser: LoggedUser

    var body: some View {
        TabView {
            BookListView(books: Book.sampleData)
                .tabItem {
                    Label("Knihotéka", systemImage: "books.vertical")
                }
            
            CustomerListView(customers: UserModel.sampleData)
                .tabItem {
                    Label("Čtenáři", systemImage: "person.3.sequence.fill")
                }
            NavigationView {
                AccountView(user: UserModel.sampleUser)
            }
            .tabItem {
                Label("Můj účet", systemImage: "person.crop.circle.fill")
            }
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
