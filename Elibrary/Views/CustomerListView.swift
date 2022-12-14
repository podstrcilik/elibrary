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
    
    func add() -> Void {}

    var body: some View {
        NavigationView {
            List(customers) { customer in
                CustomerListCellView(
                    id: customer.id,
                    username: customer.username,
                    name: customer.name,
                    personalIdentificationNumber: customer.personalIdentificationNumber,
                    email: customer.email
                )
                
            }
            .searchable(
                text: $searchText,
                prompt: "Vyhledej uživatele"
            )
            .navigationTitle("Zákazníci")
            .toolbar {
                
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    AddButton(onAdd: add)
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
