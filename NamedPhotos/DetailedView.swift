//
//  DetailedView.swift
//  NamedPhotos
//
//  Created by James Cao on 3/31/25.
//

import SwiftUI
import MapKit

struct DetailedView: View {
    let currPerson: Person
    let coord: CLLocationCoordinate2D
//    @State private var map: MKCoordinateRegion
    
    init(currPerson: Person) {
        self.currPerson = currPerson
        self.coord = currPerson.location.convertToLC2D()
//        self.map = MKCoordinateRegion(center: self.coord, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                currPerson.convert()
                    .resizable()
                    .scaledToFit()
                    .border(.secondary)
                    .padding()
                
                Map {
                    Marker("\(currPerson.name)", coordinate: coord)
                }
            }
            .navigationTitle("\(currPerson.name)")
        } // NavigationView
    } // body
}

//#Preview {
//    DetailedView()
//}
