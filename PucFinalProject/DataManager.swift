//
//  DataManager.swift
//  PucFinalProject
//
//  Created by Octavio Lemgruber Portugal on 05/10/23.
//

import SwiftUI
import Firebase

class DataManager: ObservableObject {
    @Published var pokemons: [Creature] = []
    
    init() {
        fetchPokemons()
    }
    
    func fetchPokemons() {
        pokemons.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Pokemons")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let name = data["pokemonName"] as? String ?? ""
                    let url = data ["url"] as? String ?? ""

                    let pokemon = Creature(name: name, url: url)
                    self.pokemons.append(pokemon)
                }
            }
        }
    }
    
    func addPokemon(creature: Creature) {
        let db = Firestore.firestore()
        let ref = db.collection("Pokemons").document(creature.name)
        ref.setData(["id": creature.id, "pokemonName": creature.name, "url": creature.url]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
