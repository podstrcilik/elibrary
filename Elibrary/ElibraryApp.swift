//
//  ElibraryApp.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 22.10.2022.
//

import SwiftUI

@main
struct ElibraryApp: App {
    @State private var showAlert = false
    @State private var alertData = AlertData.empty

    var body: some Scene {
        WindowGroup {
            LoginView()
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
}

public extension Notification.Name {
  static let showAlert = Notification.Name("showAlert")
}

struct AlertData {
  let title: Text
  let message: Text?
  let dismissButton: Alert.Button?

  static let empty = AlertData(title: Text(""),
                               message: nil,
                               dismissButton: nil)
}
