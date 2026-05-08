//
//  Seat.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import Foundation

// A small enum makes invalid seat states harder to represent in the UI.
enum SeatStatus: String, Codable {
    case available
    case selected
    case unavailable
}

struct Seat: Identifiable, Codable, Hashable {
    let row: String
    let number: Int
    let status: SeatStatus

    // Builds the seat ID from its row and number.
    var id: String {
        "\(row)\(number)"
    }

    // Shows the seat label in the UI.
    var label: String {
        id
    }
}
