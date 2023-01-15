//
//  CustomAsyncImage.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 15.01.2023.
//

import Foundation
import SwiftUI

struct CustomImageView: View {
    var urlString: String
    @ObservedObject var imageLoader = ImageLoaderService()
    @State var image: UIImage = UIImage()

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width:100, height:100)
            .onReceive(imageLoader.$image) { image in
                self.image = image
            }
            .onAppear {
                imageLoader.loadImage(for: urlString)
            }
    }
}


class ImageLoaderService: ObservableObject {
    @Published var image: UIImage = UIImage()

    func loadImage(for urlString: String) {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.addValue("Basic \(Networking.shared.apiKey ?? "")", forHTTPHeaderField: "Authorization")



        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data) ?? UIImage()
            }
        }
        task.resume()
    }

}
