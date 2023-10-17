//
//  Creature.swift
//  PucFinalProject
//
//  Created by Octavio Lemgruber Portugal on 14/10/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Creature: Codable, Identifiable {
    @DocumentID var idString: String?
    let id = UUID().uuidString
    var name: String
    var url: String
    
    var dictionary: [String: Any] {
        return ["name": name, "url": url]
    }
    
    enum CodingKeys: CodingKey {
        case name, url
    }
}
