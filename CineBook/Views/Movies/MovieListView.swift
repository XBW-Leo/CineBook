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

    // Broad genre categories following industry standard (Netflix / Fandango style).
    // Maps display label → raw genre values in MovieCatalog.
    private static let genreCategories: [(label: String, matches: [String])] = [
        ("Action",    ["Action Comedy", "Adventure Comedy"]),
        ("Animation", ["Animation"]),
        ("Drama",     ["Drama", "Romance", "Mystery Drama"]),
        ("Thriller",  ["Sci-Fi Thriller", "Spy Thriller"]),
    ]

    private var displayedMovies: [Movie] {
        if isSearchActive {
            guard !searchText.isEmpty else { return [] }
            return movies.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.genre.localizedCaseInsensitiveContains(searchText)
            }
        }
        guard let selectedGenre else { return movies }
        let matches = Self.genreCategories.first { $0.label == selectedGenre }?.matches ?? [selectedGenre]
        return movies.filter { matches.contains($0.genre) }
    }

    var body: some View {
        VStack(spacing: 0) {
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
                                MovieDetailView(movie: movie)
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
}

#Preview {
    NavigationStack {
        MovieListView()
    }
    .environmentObject(BookingStore())
}
