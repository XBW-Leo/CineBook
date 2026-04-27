//
//  CinemaSession.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import Foundation

struct CinemaSession: Identifiable, Codable, Hashable {
    let id: String
    let startsAt: Date
    let screenName: String
    let ticketPrice: Double

    // Seats that are already sold before the user opens this session.
    // User-created bookings are added separately by BookingStore.
    let unavailableSeatIDs: Set<String>

    var startTimeText: String {
        Self.displayFormatter.string(from: startsAt)
    }

    private static let displayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, d MMM · h:mm a"
        return formatter
    }()
}
