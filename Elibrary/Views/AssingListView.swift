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

    var body: some View {
        List(viewModel.customers) { customer in
                CustomerListCellView(
                    id: customer.id,
                    username: customer.username,
                    name: "\(customer.firstName + " " + customer.lastName)",
                    personalIdentificationNumber: customer.birthNumber,
                    address: "\(customer.address.street) \n\(customer.address.city) \(customer.address.postcode)",
                    banned: customer.isBanned,
                    approved: customer.isApproved
                )
                .onTapGesture {
                    viewModel.assignBook(book: book, user: customer)
                }
        }
        .refreshable {
            viewModel.fetch()
        }
        .onAppear(perform: {
            viewModel.fetch()
        })

    }
}
