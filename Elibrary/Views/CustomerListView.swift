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
    @State var selectedIndex: String?
    @EnvironmentObject var loggedUser: LoggedUser

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
                        address: "\(customer.address.street) \n\(customer.address.city) \(customer.address.postcode)",
                        banned: customer.isBanned,
                        approved: customer.isApproved
                    )
                }
                .swipeActions() {
                    if !customer.isBanned, loggedUser.isLibrarian {
                        Button("Ban") {
                            viewModel.makeBanRequest(userId: customer.id)
                        }.tint(.red)
                    }
                    if !customer.isApproved, loggedUser.isLibrarian {
                        Button("Schválit") {
                            viewModel.makeApproveRequest(userId: customer.id)

                        }.tint(.green)
                    }
                }
            }
            .refreshable {
                viewModel.fetch()
            }
            .searchable(text: $searchText, prompt: "Vyhledej čtenáře")
            .onChange(of: searchText) { searchText in
                viewModel.fetch(search: searchText)
            }
            .navigationTitle("Čtenáři")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if loggedUser.isLibrarian {
                        AddButton(onAdd: add)
                    }
                    Menu(content: {
                        Section("Řadit podle") {
                            Button(action: {
                                //                            showNewBookModal.toggle()
                                viewModel.orderKey = "firstName"
                                viewModel.fetch()
                                selectedIndex = viewModel.orderKey
                            }) {
                                if selectedIndex == "firstName" {
                                    Label("Jméno", systemImage: "checkmark")
                                } else {
                                    Text("Jméno")
                                }
                            }
                            Button(action: {
                                viewModel.orderKey = "lastName"
                                viewModel.fetch()
                                selectedIndex = viewModel.orderKey
                            }) {
                                if selectedIndex == "lastName" {
                                    Label("Příjmení", systemImage: "checkmark")
                                } else {
                                    Text("Příjmení")
                                }
                            }
                            Button(action: {
                                viewModel.orderKey = "birthNumber"
                                viewModel.fetch()
                                selectedIndex = viewModel.orderKey
                            }) {
                                if selectedIndex == "birthNumber" {
                                    Label("Rodné číslo", systemImage: "checkmark")
                                } else {
                                    Text("Rodné číslo")
                                }
                            }
                            Button(action: {
                                viewModel.orderKey = "address.city"
                                viewModel.fetch()
                                selectedIndex = viewModel.orderKey
                            }) {
                                if selectedIndex == "address.city" {
                                    Label("Město", systemImage: "checkmark")
                                } else {
                                    Text("Město")
                                }
                            }
                        }
                    }, label: { Image(systemName: "ellipsis.circle") })
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
            }.onDisappear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    viewModel.fetch()
            }
            })
        }
    }
}

struct CustomerListView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerListView(customers: UserModel.sampleData)
    }
}
