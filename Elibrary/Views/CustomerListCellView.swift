//
//  CustomerListCellView.swift
//  Elibrary
//
//  Created by Kristýna Tomanová on 07.12.2022.
//

import SwiftUI

struct CustomerListCellView: View {
    var id: String
    @State var username: String
    @State var name: String
    @State var personalIdentificationNumber: String
    @State var address: String
    @State var banned: Bool
    @State var approved: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack {
                    Text(username)
                        .font(.headline)
                    Spacer()
                    Image(systemName: "circle.fill")
                        .foregroundColor(getCircleColor())
                        .font(.system(size: 10, weight: .bold))
                        .opacity((banned || (!approved)) ? 1 : 0)
                }
                HStack(alignment: .center) {
                    Text(name)
                }.font(.subheadline)
                
                HStack {
                    Text(address)
                    
                    Spacer()
                    
                    Text(personalIdentificationNumber)
                
                    
                }
                .font(.subheadline)
                .foregroundColor(.gray)
            }
        }
        
    }

    func getCircleColor() -> Color {
        if banned {
            return .red
        }
        if !approved {
            return .orange
        }
        return .black
    }
}

struct CustomerListCellView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerListCellView(
            id: UserModel.sampleUser.id,
            username: UserModel.sampleUser.username,
            name: UserModel.sampleUser.firstName,
            personalIdentificationNumber: UserModel.sampleUser.birthNumber,
            address: "UserModel.sampleUser.email",
            banned: false,
            approved: false
        )
    }
}
