//
//  Movie.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import Foundation

// Visual themes are kept with the movie data so new content can be added
// without changing the reusable poster component.
enum MovieTheme: String, Codable, Hashable {
    case midnight
    case orchard
    case fastLane
    case ocean
    case noir
    case sunset
    case arcade
    case skyline
}

struct Movie: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let genre: String
    let durationMinutes: Int
    let ageRating: String
    let userRating: Double
    let summary: String
    let posterSymbol: String
    let theme: MovieTheme
    let sessions: [CinemaSession]

    var durationText: String {
        "\(durationMinutes) min"
    }
}
