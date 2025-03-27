//
//  Person.swift
//  NamedPhotos
//
//  Created by James Cao on 3/27/25.
//

import SwiftUI
import UIKit

struct Person: Equatable, Identifiable, Codable {
    var id: UUID
    var name: String
    var avatar: Data

    init(name: String, avatar: Data) {
        self.id = UUID()
        self.name = name
        self.avatar = avatar
    }

    // converts image data into a viewable image, otherwise uses a placeholder
    func convert() -> Image {
        let uiImageData = avatar
        if let uiImage = UIImage(data: uiImageData) {
            return Image(uiImage: uiImage)
        }
        return Image(systemName: "questionmark.square.dashed")
    }

    // used for sorting
    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}
