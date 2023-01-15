//
//  CustomerListView.swift
//  Elibrary
//
//  Created by Kristýna Tomanová on 07.12.2022.
//

import SwiftUI

struct CustomerListView: View {
    @State private var searchText = ""
    @State var customers: [UserModel]
    @State private var showNewBookModal = false
    @StateObject var viewModel = CustomerViewModel()

    func add() -> Void {
        showNewBookModal.toggle()
    }

    var body: some View {
        NavigationView {
            List(viewModel.customers) { customer in
                NavigationLink(destination: AccountView(user: customer)) {
                    CustomerListCellView(
                        id: customer.id,
                        username: customer.username,
                        name: "\(customer.firstName + " " + customer.lastName)",
                        personalIdentificationNumber: customer.birthNumber,
                        address: "\(customer.address.street) \n\(customer.address.city) \(customer.address.postcode)"
                    )
                }
                .swipeActions() {
                    Button("Ban") {
                    }.tint(.red)
                    Button("Schválit") {
                    }.tint(.green)
                }
            }
            .refreshable {
                viewModel.fetch()
            }
            .searchable(
                text: $searchText,
                prompt: "Vyhledej čtenáře"
            )
            .navigationTitle("Čtenáři")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    AddButton(onAdd: add)
                }
            }
        }
        .onAppear(perform: {
            viewModel.fetch()
        })
        .sheet(isPresented: $showNewBookModal) {
            NavigationView {
                EditAccountView(user: UserModel(id: "", firstName: "", lastName: "", birthNumber: "", username: "", role: "", isApproved: true, isBanned: false, address: Address(street: "", city: "", postcode: "")), showModal: self.$showNewBookModal)
                .navigationTitle("Nový uživatel")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Zavřít") {
                            showNewBookModal.toggle()
                        }
                    }
                }
            }
        }
    }
}

struct CustomerListView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerListView(customers: UserModel.sampleData)
    }
}
