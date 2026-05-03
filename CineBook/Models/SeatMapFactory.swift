//
//  SeatMapFactory.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import Foundation

// Converts simple seat IDs into the seat objects used by the UI.
// Keeping this outside the view makes the seating layout easier to change later.
enum SeatMapFactory {
    static let rows = ["A", "B", "C", "D", "E"]
    static let seatsPerRow = 8

    static func makeSeats(
        unavailableSeatIDs: Set<String>,
        selectedSeatIDs: Set<String>
    ) -> [Seat] {
        rows.flatMap { row in
            (1...seatsPerRow).map { number in
                let seatID = "\(row)\(number)"

                let status: SeatStatus
                if unavailableSeatIDs.contains(seatID) {
                    status = .unavailable
                } else if selectedSeatIDs.contains(seatID) {
                    status = .selected
                } else {
                    status = .available
                }

                return Seat(row: row, number: number, status: status)
            }
        }
    }

    static func sortedSeatIDs(_ seatIDs: [String]) -> [String] {
        seatIDs.sorted { left, right in
            let leftKey = seatSortKey(left)
            let rightKey = seatSortKey(right)

            if leftKey.row == rightKey.row {
                return leftKey.number < rightKey.number
            }

            return leftKey.row < rightKey.row
        }
    }

    private static func seatSortKey(_ seatID: String) -> (row: String, number: Int) {
        let row = String(seatID.prefix(1))
        let number = Int(seatID.dropFirst()) ?? 0
        return (row, number)
    }
}
