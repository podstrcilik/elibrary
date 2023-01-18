//
//  Networking.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 15.01.2023.
//

import Foundation
import SwiftUI

class Networking {

    var urlSession = URLSession.shared
    var baseUrl = "https://bookify-backend.dev07.b2a.cz"
    var apiKey: String?

    static let shared = Networking()
    private init() {}

    func sendPostRequest(
        to url: String,
        body: Data,
        then handler: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let url = URL(string: baseUrl+url) else {
            return
        }

        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData
        )

        if let apiKey {
            request.addValue("Basic \(apiKey)", forHTTPHeaderField: "Authorization")
        }

        request.httpMethod = "POST"
        request.httpBody = body

        let task = urlSession.dataTask(
            with: request,
            completionHandler: { data, response, error in

                do {
                    if let json = try JSONSerialization.jsonObject(with: data ?? Data(), options: []) as? [String: Any] {
                        if (json["error"] as? Bool) == true {
                            let messages = json["messages"] as? [String]
                            handler(Result.failure(MessageError.error(messages: messages ?? ["N/A"])))
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: .showAlert,
                                                                object: AlertData(title: Text("Error"),
                                                                                  message: Text(messages?.joined(separator: " ") ?? "N/A"),
                                                                                  dismissButton: .default(Text("OK")) {
                                    handler(Result.failure(MessageError.error(messages: messages ?? ["N/A"])))

                                }))}

                        } else {
                            handler(Result.success(data ?? Data()))
                        }
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            }
        )

        task.resume()
    }

    func sendPutRequest(
        to url: String,
        body: Data?,
        then handler: @escaping (Result<Data, Error>) -> Void
    ) {

        var request = URLRequest(
            url: URL(string: baseUrl+url)!,
            cachePolicy: .reloadIgnoringLocalCacheData
        )

        if let apiKey {
            request.addValue("Basic \(apiKey)", forHTTPHeaderField: "Authorization")
        }

        request.httpMethod = "PUT"
        if let body {
            request.httpBody = body
        }

        let task = urlSession.dataTask(
            with: request,
            completionHandler: { data, response, error in
                do {
                    if let json = try JSONSerialization.jsonObject(with: data ?? Data(), options: []) as? [String: Any] {
                        if (json["error"] as? Bool) == true {
                            let messages = json["messages"] as? [String]
                            handler(Result.failure(MessageError.error(messages: messages ?? ["N/A"])))
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: .showAlert,
                                                                object: AlertData(title: Text("Error"),
                                                                                  message: Text(messages?.joined(separator: " ") ?? "N/A"),
                                                                                  dismissButton: .default(Text("OK")) {
                                    handler(Result.failure(MessageError.error(messages: messages ?? ["N/A"])))

                                }))}

                        } else {
                            handler(Result.success(data ?? Data()))
                        }
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            }
        )

        task.resume()
    }

    func getRequest(
        to url: String,
        then handler: @escaping (Result<Data, Error>) -> Void
    ) {

        guard let url = URL(string: baseUrl+url) else {
            return
        }
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData
        )

        request.addValue("Basic \(apiKey ?? "")", forHTTPHeaderField: "Authorization")


        let task = urlSession.dataTask(
            with: request,
            completionHandler: { data, response, error in
                do {
                    // make sure this JSON is in the format we expect
                    if let json = try JSONSerialization.jsonObject(with: data ?? Data(), options: []) as? [String: Any] {
                        // try to read out a string array
                        if (json["error"] as? Bool) == true {
                            let messages = json["messages"] as? [String]
                            handler(Result.failure(MessageError.error(messages: messages ?? ["N/A"])))
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: .showAlert,
                                                                object: AlertData(title: Text("Error"),
                                                                                  message: Text(messages?.joined() ?? "N/A"),
                                                                                  dismissButton: .default(Text("OK")) {
                                    handler(Result.failure(MessageError.error(messages: messages ?? ["N/A"])))

                                }))}

                        } else {
                            handler(Result.success(data ?? Data()))
                        }
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            }
        )

        task.resume()
    }

    func uploadImage(image: Data) {
        let semaphore = DispatchSemaphore (value: 0)

        let parameters = [
          [
            "key": "image",
            "src": "/Users/pavelodstrcilik/Desktop/Snímek obrazovky 2020-06-11 v 15.55.49.png",
            "type": "file"
          ]] as [[String : Any]]

        let boundary = "Boundary-\(UUID().uuidString)"
        var body = ""
        for param in parameters {
          if param["disabled"] == nil {
            let paramName = param["key"]!
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"\(paramName)\""
            if param["contentType"] != nil {
              body += "\r\nContent-Type: \(param["contentType"] as! String)"
            }
            let paramType = param["type"] as! String
            if paramType == "text" {
              let paramValue = param["value"] as! String
              body += "\r\n\r\n\(paramValue)\r\n"
            } else {
              let paramSrc = param["src"] as! String
              body += "; filename=\"\(paramSrc)\"\r\n"
                + "Content-Type: \"content-type header\"\r\n\r\n\(image)\r\n"
            }
          }
        }
        body += "--\(boundary)--\r\n";
        let postData = body.data(using: .utf8)

        guard let url = URL(string: "https://bookify-backend.dev07.b2a.cz/api/v1/file/upload") else {
            return
        }

        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.addValue("Basic \(apiKey ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }

    func uploadImage(paramName: String, fileName: String, image: UIImage, handler: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "https://bookify-backend.dev07.b2a.cz/api/v1/file/upload")

        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString

        let session = URLSession.shared

        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"

        if let apiKey {
            urlRequest.addValue("Basic \(apiKey)", forHTTPHeaderField: "Authorization")
        }


        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()

        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)

        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            handler(Result.success(responseData ?? Data()))
        }).resume()
    }

    func deleteRequest(
        to url: String,
        then handler: @escaping (Result<Data, Error>) -> Void
    ) {
        // To ensure that our request is always sent, we tell
        // the system to ignore all local cache data:
        var request = URLRequest(
            url: URL(string: baseUrl+url)!,
            cachePolicy: .reloadIgnoringLocalCacheData
        )

        if let apiKey {
            request.addValue("Basic \(apiKey)", forHTTPHeaderField: "Authorization")
        }

        request.httpMethod = "DELETE"

        let task = urlSession.dataTask(
            with: request,
            completionHandler: { data, response, error in
                handler(Result.success(data ?? Data()))
            }
        )

        task.resume()
    }


}
