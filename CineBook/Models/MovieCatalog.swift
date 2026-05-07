//
//  MovieCatalog.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import Foundation

enum MovieCatalog {
    // The catalogue is the single source of sample movie content for the MVP.
    // New movies, sessions, prices, or unavailable seats can be added here
    // without changing the list, detail, or seat-selection views.
    static let movies: [Movie] = [
        Movie(
            id: "midnight-signal",
            title: "Midnight Signal",
            genre: "Sci-Fi Thriller",
            durationMinutes: 124,
            ageRating: "M",
            userRating: 4.6,
            summary: "A young engineer discovers a mysterious signal from deep space and must decide whether it is a warning or an invitation.",
            posterSymbol: "antenna.radiowaves.left.and.right",
            theme: .midnight,
            sessions: [
                session("midnight-1830", 0, 18, 30, "Screen 2", 18.50, ["A2", "A3", "B5", "C1", "D6"]),
                session("midnight-2045", 0, 20, 45, "Screen 4", 19.00, ["A1", "B2", "B3", "C6", "E4"]),
                session("midnight-1740", 1, 17, 40, "Screen 5", 18.00, ["A5", "B1", "C2", "D7"]),
                session("midnight-2105", 2, 21, 5, "Screen 3", 19.50, ["A6", "B4", "C5", "E2"]),
                session("midnight-3-1915", 3, 19, 15, "Screen 2", 19.00, ["A4", "B7", "C3", "D1"]),
                session("midnight-4-2040", 4, 20, 40, "Screen 6", 19.50, ["A8", "B1", "C6", "E3"]),
                session("midnight-5-1810", 5, 18, 10, "Screen 4", 18.50, ["A2", "C4", "D5", "E7"]),
                session("midnight-6-2130", 6, 21, 30, "Screen 3", 20.00, ["A5", "B3", "C8", "D6"])
            ]
        ),

        Movie(
            id: "last-orchard",
            title: "The Last Orchard",
            genre: "Drama",
            durationMinutes: 112,
            ageRating: "PG",
            userRating: 4.4,
            summary: "A family returns to their rural hometown to save an old orchard, confronting memories, conflict and the meaning of home.",
            posterSymbol: "leaf",
            theme: .orchard,
            sessions: [
                session("orchard-1715", 0, 17, 15, "Screen 1", 16.50, ["A4", "B4", "C2", "C3"]),
                session("orchard-1910", 1, 19, 10, "Screen 3", 17.00, ["A7", "D1", "D2", "E5"]),
                session("orchard-1410", 1, 14, 10, "Screen 2", 15.50, ["A1", "B2", "C5", "D4"]),
                session("orchard-2010", 2, 20, 10, "Screen 6", 17.50, ["A6", "B6", "C1", "E3"]),
                session("orchard-3-1500", 3, 15, 0, "Screen 1", 16.00, ["A3", "B5", "C7", "D2"]),
                session("orchard-4-1825", 4, 18, 25, "Screen 5", 17.00, ["A2", "B8", "D4", "E1"]),
                session("orchard-5-1335", 5, 13, 35, "Screen 2", 15.50, ["A6", "C1", "C2", "E5"]),
                session("orchard-6-1905", 6, 19, 5, "Screen 6", 17.50, ["A1", "B3", "D7", "E2"])
            ]
        ),

        Movie(
            id: "fast-lane-weekend",
            title: "Fast Lane Weekend",
            genre: "Action Comedy",
            durationMinutes: 105,
            ageRating: "M",
            userRating: 4.2,
            summary: "Two friends accidentally enter an underground race and have one weekend to escape trouble, fix their friendship and find the finish line.",
            posterSymbol: "car",
            theme: .fastLane,
            sessions: [
                session("fastlane-2120", 0, 21, 20, "Screen 5", 18.00, ["A5", "B1", "B8", "D4", "E6"]),
                session("fastlane-1840", 1, 18, 40, "Screen 2", 18.50, ["A2", "A6", "C5", "D7"]),
                session("fastlane-1545", 1, 15, 45, "Screen 7", 17.50, ["A4", "B3", "C1", "E8"]),
                session("fastlane-2030", 2, 20, 30, "Screen 4", 19.00, ["A1", "B5", "C6", "D2"]),
                session("fastlane-3-1745", 3, 17, 45, "Screen 7", 18.00, ["A8", "B2", "C4", "E1"]),
                session("fastlane-4-2110", 4, 21, 10, "Screen 5", 19.00, ["A3", "B6", "C7", "D5"]),
                session("fastlane-5-1605", 5, 16, 5, "Screen 3", 17.50, ["A4", "B7", "D1", "E6"]),
                session("fastlane-6-2020", 6, 20, 20, "Screen 4", 19.50, ["A2", "C3", "D8", "E4"])
            ]
        ),

        Movie(
            id: "ocean-of-stars",
            title: "Ocean of Stars",
            genre: "Animation",
            durationMinutes: 98,
            ageRating: "PG",
            userRating: 4.8,
            summary: "A curious child follows a glowing tide into a magical ocean where stars are born, learning courage and responsibility along the way.",
            posterSymbol: "sparkles",
            theme: .ocean,
            sessions: [
                session("ocean-1430", 1, 14, 30, "Screen 1", 15.00, ["A1", "A2", "B3", "C7"]),
                session("ocean-1645", 1, 16, 45, "Screen 4", 15.50, ["B6", "C1", "C2", "D3", "E8"]),
                session("ocean-1115", 2, 11, 15, "Screen 2", 14.50, ["A4", "B1", "C4", "D7"]),
                session("ocean-1810", 2, 18, 10, "Screen 5", 15.50, ["A8", "B7", "C3", "E2"]),
                session("ocean-3-1030", 3, 10, 30, "Screen 1", 14.50, ["A5", "B4", "C6", "D2"]),
                session("ocean-4-1540", 4, 15, 40, "Screen 4", 15.50, ["A7", "B2", "D1", "E5"]),
                session("ocean-5-1215", 5, 12, 15, "Screen 2", 14.50, ["A3", "B8", "C1", "E4"]),
                session("ocean-6-1700", 6, 17, 0, "Screen 5", 16.00, ["A6", "B5", "C7", "D4"])
            ]
        ),

        Movie(
            id: "shadow-protocol",
            title: "Shadow Protocol",
            genre: "Spy Thriller",
            durationMinutes: 118,
            ageRating: "M",
            userRating: 4.5,
            summary: "A former intelligence analyst is pulled back into the field after discovering a hidden operation that threatens an entire city.",
            posterSymbol: "eye",
            theme: .noir,
            sessions: [
                session("shadow-1930", 0, 19, 30, "Screen 6", 19.50, ["A6", "B6", "C4", "D2", "E1"]),
                session("shadow-2200", 1, 22, 0, "Screen 3", 20.00, ["A1", "A8", "B4", "C5", "D6"]),
                session("shadow-1700", 1, 17, 0, "Screen 4", 18.50, ["A3", "B2", "C1", "E4"]),
                session("shadow-2050", 2, 20, 50, "Screen 7", 20.50, ["A7", "B5", "C8", "D3"]),
                session("shadow-3-2145", 3, 21, 45, "Screen 6", 20.00, ["A2", "B7", "C6", "E8"]),
                session("shadow-4-1850", 4, 18, 50, "Screen 3", 19.50, ["A4", "B1", "D2", "E5"]),
                session("shadow-5-2205", 5, 22, 5, "Screen 7", 20.50, ["A8", "B6", "C3", "D4"]),
                session("shadow-6-1935", 6, 19, 35, "Screen 4", 19.50, ["A1", "C2", "D7", "E3"])
            ]
        ),

        Movie(
            id: "summer-notes",
            title: "Summer Notes",
            genre: "Romance",
            durationMinutes: 101,
            ageRating: "PG",
            userRating: 4.3,
            summary: "Two music students spend one summer writing songs together, slowly learning that unfinished melodies can still change their lives.",
            posterSymbol: "music.note",
            theme: .sunset,
            sessions: [
                session("summer-1600", 0, 16, 0, "Screen 2", 16.00, ["A3", "B2", "B7", "C8"]),
                session("summer-2015", 1, 20, 15, "Screen 5", 17.50, ["A4", "C1", "C2", "D8", "E7"]),
                session("summer-1320", 1, 13, 20, "Screen 1", 15.50, ["A1", "B4", "D1", "E2"]),
                session("summer-1845", 2, 18, 45, "Screen 6", 17.00, ["A5", "B6", "C3", "D4"]),
                session("summer-3-1240", 3, 12, 40, "Screen 2", 15.50, ["A2", "B5", "C1", "E6"]),
                session("summer-4-1705", 4, 17, 5, "Screen 1", 16.50, ["A7", "B1", "D3", "E4"]),
                session("summer-5-2010", 5, 20, 10, "Screen 5", 17.50, ["A4", "B8", "C6", "D2"]),
                session("summer-6-1435", 6, 14, 35, "Screen 6", 16.00, ["A1", "C5", "D8", "E2"])
            ]
        ),

        Movie(
            id: "pixel-runners",
            title: "Pixel Runners",
            genre: "Adventure Comedy",
            durationMinutes: 96,
            ageRating: "PG",
            userRating: 4.1,
            summary: "A group of teenagers are pulled into an old arcade game and must work together to clear each level before the machine shuts down.",
            posterSymbol: "gamecontroller",
            theme: .arcade,
            sessions: [
                session("pixel-1330", 1, 13, 30, "Screen 1", 14.50, ["A1", "B1", "B2", "D5"]),
                session("pixel-1745", 1, 17, 45, "Screen 4", 16.00, ["A8", "B8", "C4", "D3", "E2"]),
                session("pixel-1200", 2, 12, 0, "Screen 3", 14.50, ["A3", "B5", "C6", "D7"]),
                session("pixel-1930", 2, 19, 30, "Screen 5", 16.50, ["A6", "B4", "C2", "E1"]),
                session("pixel-3-1110", 3, 11, 10, "Screen 3", 14.50, ["A2", "B7", "D4", "E5"]),
                session("pixel-4-1630", 4, 16, 30, "Screen 4", 16.00, ["A6", "B3", "C8", "D1"]),
                session("pixel-5-1800", 5, 18, 0, "Screen 1", 16.50, ["A8", "B2", "C5", "E3"]),
                session("pixel-6-1255", 6, 12, 55, "Screen 5", 15.00, ["A4", "B6", "C1", "D7"])
            ]
        ),

        Movie(
            id: "city-after-rain",
            title: "City After Rain",
            genre: "Mystery Drama",
            durationMinutes: 109,
            ageRating: "M",
            userRating: 4.7,
            summary: "After a stormy night, a journalist finds a clue linking several unsolved cases across the city and begins following a dangerous trail.",
            posterSymbol: "cloud.rain",
            theme: .skyline,
            sessions: [
                session("rain-1810", 0, 18, 10, "Screen 7", 18.00, ["A5", "B3", "B4", "C6", "D1"]),
                session("rain-2100", 1, 21, 0, "Screen 6", 18.50, ["A2", "A7", "C2", "D4", "E6"]),
                session("rain-1530", 1, 15, 30, "Screen 2", 17.50, ["A1", "B6", "C3", "D8"]),
                session("rain-1940", 2, 19, 40, "Screen 4", 18.50, ["A4", "B2", "C7", "E5"]),
                session("rain-3-2000", 3, 20, 0, "Screen 7", 19.00, ["A1", "B5", "C4", "E8"]),
                session("rain-4-1420", 4, 14, 20, "Screen 2", 17.50, ["A3", "B7", "D6", "E1"]),
                session("rain-5-1915", 5, 19, 15, "Screen 6", 18.50, ["A6", "B1", "C8", "D3"]),
                session("rain-6-2115", 6, 21, 15, "Screen 4", 19.00, ["A2", "C5", "D7", "E4"])
            ]
        )
    ]

    // A small helper keeps the catalogue readable while still producing real Date values.
    // Creates a cinema session from relative day and time values.
    private static func session(
        _ id: String,
        _ daysFromToday: Int,
        _ hour: Int,
        _ minute: Int,
        _ screenName: String,
        _ ticketPrice: Double,
        _ unavailableSeatIDs: [String]
    ) -> CinemaSession {
        CinemaSession(
            id: id,
            startsAt: sessionDate(daysFromToday: daysFromToday, hour: hour, minute: minute),
            screenName: screenName,
            ticketPrice: ticketPrice,
            unavailableSeatIDs: Set(unavailableSeatIDs)
        )
    }

    // Builds a Date by adding days to today and setting the time.
    private static func sessionDate(daysFromToday: Int, hour: Int, minute: Int) -> Date {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let targetDay = calendar.date(byAdding: .day, value: daysFromToday, to: today) ?? today

        return calendar.date(
            bySettingHour: hour,
            minute: minute,
            second: 0,
            of: targetDay
        ) ?? targetDay
    }
}
