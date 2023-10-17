//
//  PokemonList.swift
//  PucFinalProject
//
//  Created by Octavio Lemgruber Portugal on 05/10/23.
//

import SwiftUI
import Firebase

struct PokemonList: View {
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.dismiss) private var dismiss
    @State private var showPopUp = false
    
    
    var body: some View {
        NavigationStack {
            List(dataManager.pokemons, id: \.id) { pokemon in
                NavigationLink {
                    DetailView(creature: pokemon)
                } label: {
                    Text(pokemon.name.capitalized)
                        .font(.title2)
                }
            }
        }
        .navigationTitle("My Pokemons List")
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            PokemonList()
                .environmentObject(DataManager())
        }
    }
}
