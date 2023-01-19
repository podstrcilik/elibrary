//
//  AssingListView.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 18.01.2023.
//

import SwiftUI

struct AssingListView: View {
    @StateObject var viewModel = AssignViewModel()
    @State var book: Book
    @State private var showAlert = false
    @State private var alertData = AlertData.empty

    var body: some View {
        List(viewModel.customers) { customer in
            Button(action: {
                viewModel.assignBook(book: book, user: customer)
            }) {
                CustomerListCellView(
                    id: customer.id,
                    username: customer.username,
                    name: "\(customer.firstName + " " + customer.lastName)",
                    personalIdentificationNumber: customer.birthNumber,
                    address: "\(customer.address.street) \n\(customer.address.city) \(customer.address.postcode)",
                    banned: customer.isBanned,
                    approved: customer.isApproved
                )
            }.buttonStyle(.plain)
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
                  dismissButton: alertData.dismissButton)}
        .refreshable {
            viewModel.fetch()
        }
        .onAppear(perform: {
            viewModel.fetch()
        })
        

    }
}
