//
//  Person.swift
//  NamedPhotos
//
//  Created by James Cao on 3/27/25.
//

import SwiftUI
import UIKit
import MapKit

struct Person: Equatable, Identifiable, Codable {
    var id: UUID
    var name: String
    var avatar: Data
    var location: Coordinate

    init(name: String, avatar: Data, location: Coordinate) {
        self.id = UUID()
        self.name = name
        self.avatar = avatar
        self.location = location
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
    
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double
    
    func convertToLC2D () -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    static func convertFromLC2D (_ coord: CLLocationCoordinate2D) -> Coordinate {
        return Coordinate(latitude: coord.latitude, longitude: coord.longitude)
    }
    
//    static func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
//        return (lhs.latitude == rhs.latitude) && (lhs.longitude == rhs.longitude)
//    }
}
