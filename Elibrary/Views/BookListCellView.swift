//
//  BookListCellView.swift
//  Elibrary
//
//  Created by Kristýna Tomanová on 23.11.2022.
//

import SwiftUI

struct BookListCellView: View {
    
    @State var title: String
    @State var author: String
    @State var pageCount: Int
    @State var yearPublished: String
    @State var availableCount: Int
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text(title)
                        .font(.headline)
                }
                
                HStack() {
                    Text(author)
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Text(yearPublished)
                        .font(.subheadline)
                }
            }
        }.foregroundColor(availableCount > 0 ? Color.black : Color.gray)
    }
}

struct BookListCellView_Previews: PreviewProvider {
    static var previews: some View {
        BookListCellView(
            title: "Kniha",
            author: "Autor",
            pageCount: 220,
            yearPublished: "2022",
            availableCount: 10
        )
    }
    
}
