//
//  MovieListView.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import SwiftUI

struct MovieListView: View {
    private let movies = MovieCatalog.movies

    @State private var isSearchActive = false
    @State private var searchText = ""
    @State private var selectedGenre: String?
    @State private var selectedDate = Date()

    // Broad genre categories following industry standard (Netflix / Fandango style).
    // Maps display label → raw genre values in MovieCatalog.
    private static let genreCategories: [(label: String, matches: [String])] = [
        ("Action",    ["Action Comedy", "Adventure Comedy"]),
        ("Animation", ["Animation"]),
        ("Drama",     ["Drama", "Romance", "Mystery Drama"]),
        ("Thriller",  ["Sci-Fi Thriller", "Spy Thriller"]),
    ]

    private var dateOptions: [Date] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        return (0..<7).compactMap { offset in
            calendar.date(byAdding: .day, value: offset, to: today)
        }
    }

    private var displayedMovies: [Movie] {
        let calendar = Calendar.current

        return movies.filter { movie in
            let hasSessionOnSelectedDate = movie.sessions.contains { session in
                calendar.isDate(session.startsAt, inSameDayAs: selectedDate)
            }

            guard hasSessionOnSelectedDate else {
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

    var body: some View {
        VStack(spacing: 0) {
            dateSelectorView
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(Color(.systemBackground))

            if isSearchActive {
                searchBar
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(Color(.systemBackground))
            } else {
                genreFilterView
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(Color(.systemBackground))
            }

            Divider()

            if isSearchActive && searchText.isEmpty {
                Spacer()
                VStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 44))
                        .foregroundStyle(.secondary)
                    Text("Type to search movies or genres")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: 14) {
                        ForEach(displayedMovies) { movie in
                            NavigationLink {
                                MovieDetailView(movie: movie, selectedDate: selectedDate)
                            } label: {
                                MovieCardView(movie: movie)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("CineBook")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if !isSearchActive {
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isSearchActive = true
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
        }
        .background(Color(.systemGroupedBackground))
    }

    private var dateSelectorView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(dateOptions, id: \.self) { date in
                    dateButton(for: date)
                }
            }
        }
    }

    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField("Search movies or genres", text: $searchText)
                .autocorrectionDisabled()

            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
            }

            Button("Cancel") {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isSearchActive = false
                    searchText = ""
                }
            }
            .foregroundStyle(.blue)
        }
    }

    private var genreFilterView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                filterButton(title: "All", isSelected: selectedGenre == nil) {
                    selectedGenre = nil
                }
                ForEach(Self.genreCategories, id: \.label) { category in
                    filterButton(title: category.label, isSelected: selectedGenre == category.label) {
                        selectedGenre = category.label
                    }
                }
            }
        }
    }

    private func dateButton(for date: Date) -> some View {
        let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)

        return Button {
            selectedDate = date
        } label: {
            Text(dateButtonTitle(for: date))
                .font(.caption.weight(.semibold))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 13)
                .padding(.vertical, 9)
                .background(isSelected ? Color.blue : Color(.systemGroupedBackground))
                .clipShape(Capsule())
                .shadow(color: .black.opacity(isSelected ? 0.12 : 0.04), radius: 4, x: 0, y: 2)
        }
    }

    private func dateButtonTitle(for date: Date) -> String {
        let calendar = Calendar.current

        if calendar.isDateInToday(date) {
            return "Today"
        }

        if calendar.isDateInTomorrow(date) {
            return "Tomorrow"
        }

        return Self.shortDateFormatter.string(from: date)
    }

    private func filterButton(
        title: String,
        isSelected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 13)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemBackground))
                .clipShape(Capsule())
                .shadow(color: .black.opacity(isSelected ? 0.12 : 0.05), radius: 4, x: 0, y: 2)
            }
    }

    private static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE d"
        return formatter
    }()
}

#Preview {
    NavigationStack {
        MovieListView()
    }
    .environmentObject(BookingStore())
}
