//
//  BookingStore.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import Foundation
import Combine

final class BookingStore: ObservableObject {
    @Published private(set) var bookings: [Booking] = [] {
        didSet {
            saveBookings()
        }
    }

    private let storageKey = "cinebook.bookings.v1"

    init() {
        bookings = loadBookings()
    }

    @Published var pendingTabSwitch: Int? = nil

    var hasBookings: Bool {
        !bookings.isEmpty
    }

    var upcomingBookings: [Booking] {
        bookings
            .filter { $0.sessionTime > Date() }
            .sorted { $0.sessionTime < $1.sessionTime }
    }

    var pastBookings: [Booking] {
        bookings
            .filter { $0.sessionTime <= Date() }
            .sorted { $0.sessionTime > $1.sessionTime }
    }

    var totalSpent: Double {
        bookings.reduce(0) { $0 + $1.totalPrice }
    }

    func bookedSeatIDs(for session: CinemaSession) -> Set<String> {
        let calendar = Calendar.current

        let seats = bookings
            .filter { booking in
                booking.sessionID == session.id &&
                calendar.isDate(booking.sessionTime, equalTo: session.startsAt, toGranularity: .minute)
            }
            .flatMap { $0.seatIDs }

        return Set(seats)
    }

    @discardableResult
    func addBooking(
        movie: Movie,
        session: CinemaSession,
        selectedSeatIDs: [String]
    ) -> Booking? {
        let orderedSeats = SeatMapFactory.sortedSeatIDs(Array(Set(selectedSeatIDs)))

        guard !orderedSeats.isEmpty else {
            return nil
        }

        // Re-check availability at confirmation time. This prevents duplicate bookings
        // if the same session is opened from more than one navigation path.
        let alreadyBookedSeats = bookedSeatIDs(for: session)
        guard Set(orderedSeats).isDisjoint(with: alreadyBookedSeats) else {
            return nil
        }

        let booking = Booking(
            id: UUID(),
            movieID: movie.id,
            movieTitle: movie.title,
            posterSymbol: movie.posterSymbol,
            movieTheme: movie.theme,
            sessionID: session.id,
            sessionTime: session.startsAt,
            screenName: session.screenName,
            seatIDs: orderedSeats,
            ticketPrice: session.ticketPrice,
            createdAt: Date()
        )

        bookings.append(booking)
        return booking
    }

    func cancelBooking(_ booking: Booking) {
        bookings.removeAll { $0.id == booking.id }
    }

    private func saveBookings() {
        do {
            let data = try JSONEncoder().encode(bookings)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Failed to save bookings: \(error.localizedDescription)")
        }
    }

    private func loadBookings() -> [Booking] {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else {
            return []
        }

        do {
            return try JSONDecoder().decode([Booking].self, from: data)
        } catch {
            print("Failed to load bookings: \(error.localizedDescription)")
            return []
        }
    }
}
