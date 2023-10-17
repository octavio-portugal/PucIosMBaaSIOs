//
//  CreatureDetailViewModel.swift
//  PucFinalProject
//
//  Created by Octavio Lemgruber Portugal on 14/10/23.
//

import Foundation
import FirebaseFirestore

@MainActor
class CreatureDetailViewModel: ObservableObject {
//    @Published var creature = Creature()
    
    private struct Returned: Codable {
        var height: Double
        var weight: Double
        var sprites: Sprite?
    }
    
    struct Sprite: Codable {
        var front_default: String?
        var other: Other
    }
    
    struct Other: Codable {
        var officialArtwork: OfficialArtwork
        
        enum CodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
    }
    
    struct OfficialArtwork: Codable {
        var front_default: String?
    }
    
    var urlString = ""
    @Published var height = 0.0
    @Published var weight = 0.0
    @Published var imageURL: String? = ""
    @Published var isLoading = false

    
    func getData() async {
        print ("We are accesing the url \(urlString)")
        isLoading = true
        
        guard let url = URL(string: urlString) else {
            print("ERROR: Could not create a URL form \(urlString)")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("JSON ERROR: Could not decode returned JSON data")
                isLoading = false
                return
            }
            self.height = returned.height
            self.weight = returned.weight
            self.imageURL = returned.sprites?.other.officialArtwork.front_default ?? ""
            isLoading = false
        } catch {
            print("ERROR: Could not use URL at \(urlString) to get data and response")
            isLoading = false
        }
    }
    
//    func saveCreature(creature: Creature) async -> Bool{
//        let db = Firestore.firestore()
//        
//        if let id = creature.id {
//            do {
//                try await db.collection("creaures").document(id).setData(creature.dictionary)
//                print("Data updated successfully!")
//                return true
//            } catch {
//                print("ERROR: Could not update data in 'creature' \(error.localizedDescription)")
//                return false
//            }
//        } else {
//            do {
//                try await db.collection("creatures").addDocument(data: creature.dictionary)
//                print("Data added successfully")
//                return true
//            } catch {
//                print("ERROR: Could not create a new creature in 'creature' \(error.localizedDescription)")
//                return false
//            }
//        }
//    }
}


