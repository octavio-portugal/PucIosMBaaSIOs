//
//  Pokemon.swift
//  PucFinalProject
//
//  Created by Octavio Lemgruber Portugal on 05/10/23.
//

import SwiftUI
import Foundation

struct Pokemon: Identifiable {
    var id: String
    var name: String
    var type: String
}

struct PokemonJson: Codable {
    let id: String
    let name: String
    let type: String
    let image_path: String
}
