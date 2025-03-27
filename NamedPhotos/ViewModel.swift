//
//  ViewModel.swift
//  NamedPhotos
//
//  Created by James Cao on 3/27/25.
//

import Foundation
import UIKit

@MainActor class ViewModel: ObservableObject {
    // list of saved names + faces
    @Published private(set) var namedList: [Person]
    // photos save destination
    let savePath: URL
    
    init() {
        let fm = FileManager.default
        let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        savePath = docsurl.appendingPathComponent("SavedPersons")
        
        do {
            let personsData = try Data(contentsOf: savePath)
            namedList = try JSONDecoder().decode([Person].self, from: personsData)
        } catch {
            namedList = []
        }
    }

    // saves changes made to the save file at savePath
    func saveChanges() {
        do {
            let personsData = try JSONEncoder().encode(self.namedList)
            try personsData.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            // if have time, make this more informative?
            print("Failed to save data")
        }
    }
    
    // adds a new person (name and photo) to savePath
    func addPerson(name: String, inputUIImage: UIImage?) {
        guard let imageData = inputUIImage?.jpegData(compressionQuality: 0.8) else { return }
        let newPerson = Person(name: name, avatar: imageData)
        self.namedList.append(newPerson)
        saveChanges()
    }

    // removes a person from savePath
    func removePerson(at offsets: IndexSet) {
        self.namedList.remove(atOffsets: offsets)
        saveChanges()
    }
    
    // self explanatory
    func updateView() {
        self.objectWillChange.send()
    }
}
