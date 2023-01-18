//
//  MessageErrorEnum.swift
//  Elibrary
//
//  Created by Pavel Odstrčilík on 18.01.2023.
//

import Foundation

enum MessageError: Error {
    case error(messages: [String])
}
