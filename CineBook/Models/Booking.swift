//
//  Booking.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import Foundation

struct Booking: Identifiable, Codable, Hashable {
    let id: UUID
    let movieID: String
    let movieTitle: String
    let posterSymbol: String
    let movieTheme: MovieTheme
    let sessionID: String
    let sessionTime: Date
    let screenName: String
    let seatIDs: [String]
    let ticketPrice: Double
    let createdAt: Date

    var totalPrice: Double {
        Double(seatIDs.count) * ticketPrice
    }

    var referenceCode: String {
        String(id.uuidString.prefix(8)).uppercased()
    }

    var sessionTimeText: String {
        Self.sessionFormatter.string(from: sessionTime)
    }

    var seatText: String {
        seatIDs.joined(separator: ", ")
    }

    init(
        id: UUID,
        movieID: String,
        movieTitle: String,
        posterSymbol: String,
        movieTheme: MovieTheme,
        sessionID: String,
        sessionTime: Date,
        screenName: String,
        seatIDs: [String],
        ticketPrice: Double,
        createdAt: Date
    ) {
        self.id = id
        self.movieID = movieID
        self.movieTitle = movieTitle
        self.posterSymbol = posterSymbol
        self.movieTheme = movieTheme
        self.sessionID = sessionID
        self.sessionTime = sessionTime
        self.screenName = screenName
        self.seatIDs = seatIDs
        self.ticketPrice = ticketPrice
        self.createdAt = createdAt
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case movieID
        case movieTitle
        case posterSymbol
        case movieTheme
        case sessionID
        case sessionTime
        case screenName
        case seatIDs
        case ticketPrice
        case createdAt
    }

    // Keeps older locally saved bookings readable while the data model evolves.
    // If an older booking does not have a theme, a safe default is used.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        movieID = try container.decode(String.self, forKey: .movieID)
        movieTitle = try container.decode(String.self, forKey: .movieTitle)
        posterSymbol = try container.decode(String.self, forKey: .posterSymbol)
        movieTheme = try container.decodeIfPresent(MovieTheme.self, forKey: .movieTheme) ?? .midnight
        sessionID = try container.decode(String.self, forKey: .sessionID)
        sessionTime = try container.decode(Date.self, forKey: .sessionTime)
        screenName = try container.decode(String.self, forKey: .screenName)
        seatIDs = try container.decode([String].self, forKey: .seatIDs)
        ticketPrice = try container.decode(Double.self, forKey: .ticketPrice)
        createdAt = try container.decode(Date.self, forKey: .createdAt)
    }

    private static let sessionFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, d MMM · h:mm a"
        return formatter
    }()
}
