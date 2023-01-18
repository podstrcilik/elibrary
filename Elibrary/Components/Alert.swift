//
//  Alert.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 18.01.2023.
//

import SwiftUI

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
