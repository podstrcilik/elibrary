//
//  AddButton.swift
//  Elibrary
//
//  Created by Kristýna Tomanová on 01.12.2022.
//

import SwiftUI

struct AddButton: View {
    var onAdd: () -> Void
    
    var body: some View {
        Button(action: onAdd) {
            Image(systemName: "plus")
        }
    }
}
