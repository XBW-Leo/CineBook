//
//  MovieListView.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import SwiftUI

struct MovieListView: View {
    private let movies = MovieCatalog.movies

    @State private var searchText = ""
    @State private var selectedGenre: String?

    private var genres: [String] {
        Array(Set(movies.map { $0.genre })).sorted()
    }

    private var filteredMovies: [Movie] {
        // Search and genre filters are kept local to this screen.
        movies.filter { movie in
            let matchesSearch = searchText.isEmpty ||
                movie.title.localizedCaseInsensitiveContains(searchText) ||
                movie.genre.localizedCaseInsensitiveContains(searchText)

            let matchesGenre = selectedGenre == nil || movie.genre == selectedGenre

            return matchesSearch && matchesGenre
        }
    }

    private var minimumTicketPrice: Double {
        movies
            .flatMap { $0.sessions }
            .map(\.ticketPrice)
            .min() ?? 0
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                headerView
                genreFilterView

                LazyVStack(spacing: 14) {
                    ForEach(filteredMovies) { movie in
                        NavigationLink {
                            MovieDetailView(movie: movie)
                        } label: {
                            MovieCardView(movie: movie)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("CineBook")
        .searchable(text: $searchText, prompt: "Search movies or genres")
        .background(Color(.systemGroupedBackground))
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Book your next movie night")
                .font(.largeTitle.bold())

            Text("Browse films, choose a session across the next few days, select seats, and manage bookings in one simple flow.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineSpacing(2)

            HStack(spacing: 12) {
                statPill(title: "\(movies.count)", subtitle: "Movies")
                statPill(title: "3 Days", subtitle: "Booking Window")
                statPill(title: String(format: "$%.2f", minimumTicketPrice), subtitle: "From")
            }
            .padding(.top, 4)
        }
    }

    private var genreFilterView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                filterButton(title: "All", isSelected: selectedGenre == nil) {
                    selectedGenre = nil
                }

                ForEach(genres, id: \.self) { genre in
                    filterButton(title: genre, isSelected: selectedGenre == genre) {
                        selectedGenre = genre
                    }
                }
            }
            .padding(.vertical, 2)
        }
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

    private func statPill(title: String, subtitle: String) -> some View {
        VStack(spacing: 2) {
            Text(title)
                .font(.headline)

            Text(subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
