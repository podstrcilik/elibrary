//
//  MainTabView.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 30.11.2022.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationView {
                BaseView()
            }
                .tabItem {
                    Label("Katalog", systemImage: "list.dash")
                }
            BaseView()
                .tabItem {
                    Label("Seznam knih", systemImage: "person.crop.circle.fill")
                }
            NavigationView {
                AccountView(user: UserModel.sampleUser)
            }
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle.fill")
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
