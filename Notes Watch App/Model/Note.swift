//
//  Note.swift
//  Notes Watch App
//
//  Created by Orlando Moraes Martins on 19/02/23.
//

import Foundation


struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
