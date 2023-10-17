//
//  DetailView.swift
//  PucFinalProject
//
//  Created by Octavio Lemgruber Portugal on 14/10/23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var dataManager: DataManager
    @StateObject var creatureDetailVM = CreatureDetailViewModel()
    @State private var showingAlert = false
    var creature: Creature
    @State private var showPopUp = false
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading, spacing: 4){
                Text(creature.name.capitalized)
                    .font(Font.custom("Avenir Next Condensed", size: 60))
                    .bold()
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                
                ZStack {
                    HStack {
                        if creatureDetailVM.imageURL == "" {
                            Text("No image found")
                                .font(.body)
                                .bold()
                                .frame(maxWidth: 96,maxHeight: 96)
                                .background(.white)
                                .cornerRadius(16)
                                .shadow(radius: 8, x: 5, y: 5)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.gray.opacity(0.5), lineWidth: 1)
                                }
                                .padding(.trailing)
                        } else {
                            AsyncImage(url: URL(string: creatureDetailVM.imageURL ?? "")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .background(.white)
                                    .frame(width: 96, height: 96)
                                    .cornerRadius(16)
                                    .shadow(radius: 8, x: 5, y: 5)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(.gray.opacity(0.5), lineWidth: 1)
                                    }
                                    .padding(.trailing)
                            } placeholder: {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 96, height: 96)
                                    .padding(.trailing)
                            }
                            
                        }
                        
                        VStack (alignment: .leading){
                            HStack (alignment: .top){
                                Text("Height:")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.red)
                                
                                Text(String(format: "%.1f", creatureDetailVM.height))
                                    .font(.largeTitle)
                                    .bold()
                            }
                            
                            HStack (alignment: .top){
                                Text("Weight:")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.red)
                                
                                Text(String(format: "%.1f", creatureDetailVM.weight))
                                    .font(.largeTitle)
                                    .bold()
                            }

                        }

                    }
                    if creatureDetailVM.isLoading {
                        ProgressView()
                            .tint(.red)
                            .scaleEffect(2)
                            .padding(.trailing)
                    }
                }
                
                Spacer()
            }
            .navigationBarItems(trailing: Button(action: {
                showPopUp.toggle()
                dataManager.addPokemon(creature: creature)
                showingAlert = true
            }, label: {
                Image(systemName: "plus")
            }))
            .alert("\(creature.name.capitalized) added to your Pokemon List", isPresented: $showingAlert) {
                Button("Ok") {}
            }
            .padding()
            .task {
                creatureDetailVM.urlString = creature.url
                await creatureDetailVM.getData()
        }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(creature: Creature(name: "Bulbasur", url: "https://pokeapi.co/api/v2/pokemon/1/"))
    }
}
