//
//  MovieListViewModel.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import Foundation
import Combine

final class MovieListViewModel: ObservableObject {
    @Published var isSearchActive = false
    @Published var searchText = ""
    @Published var selectedGenre: String?
    @Published var selectedDate: Date?

    let movies: [Movie]

    // Broad genre categories following industry standard (Netflix / Fandango style).
    // Maps display label to raw genre values in MovieCatalog.
    static let genreCategories: [(label: String, matches: [String])] = [
        ("Action", ["Action Comedy", "Adventure Comedy"]),
        ("Animation", ["Animation"]),
        ("Drama", ["Drama", "Romance", "Mystery Drama"]),
        ("Thriller", ["Sci-Fi Thriller", "Spy Thriller"]),
    ]

    init(movies: [Movie] = MovieCatalog.movies) {
        self.movies = movies
    }

    var dateOptions: [Date] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        return (0..<7).compactMap { offset in
            calendar.date(byAdding: .day, value: offset, to: today)
        }
    }

    var displayedMovies: [Movie] {
        let calendar = Calendar.current

        return movies.filter { movie in
            let hasMatchingSessionDate = movie.sessions.contains { session in
                if let selectedDate {
                    return calendar.isDate(session.startsAt, inSameDayAs: selectedDate)
                }

                return dateOptions.contains { date in
                    calendar.isDate(session.startsAt, inSameDayAs: date)
                }
            }

            guard hasMatchingSessionDate else {
                return false
            }

            if isSearchActive {
                guard !searchText.isEmpty else { return false }
                guard movie.title.localizedCaseInsensitiveContains(searchText) ||
                    movie.genre.localizedCaseInsensitiveContains(searchText) else {
                    return false
                }
            }

            if let selectedGenre {
                let matches = Self.genreCategories.first { $0.label == selectedGenre }?.matches ?? [selectedGenre]
                return matches.contains(movie.genre)
            }

            return true
        }
    }

    func activateSearch() {
        isSearchActive = true
    }

    func cancelSearch() {
        isSearchActive = false
        searchText = ""
    }
}
