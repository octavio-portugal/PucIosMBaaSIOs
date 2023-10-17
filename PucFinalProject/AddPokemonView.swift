//
//  AddPokemonView.swift
//  PucFinalProject
//
//  Created by Octavio Lemgruber Portugal on 05/10/23.
//

import SwiftUI

struct AddPokemonView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var newPokemon = ""
    @Environment(\.dismiss) private var dismiss
    @StateObject var creaturesVM = CreturesViewModel()
    
    var body: some View {
        VStack {
            Group {
                TextField("Pokemon", text: $newPokemon)
                    .textFieldStyle(.roundedBorder)
            }
            .textFieldStyle(.roundedBorder)
            .overlay{
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray, lineWidth: 2)
            }
            .padding(.horizontal)
            
            
            HStack{
                Button {
//                    dataManager.addPokemon(creature: searchResults)
                } label: {
                    Text("Save")
                }
                .padding(.leading)
                .padding(.horizontal, 50)
                
                
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                .padding(.trailing)
            }
        }
    }
    
    var searchResults: [Creature] {
        return creaturesVM.creaturesArray.filter
        { $0.name.capitalized.contains(newPokemon) }
    }
}


struct AddPokemonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPokemonView()
    }
}
