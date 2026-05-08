//
//  MovieListView.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel()
    private let sessionRefreshTimer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()

    // Shows the movie browser screen.
    var body: some View {
        VStack(spacing: 0) {
            dateSelectorView
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(Color(.systemBackground))

            if viewModel.isSearchActive {
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

            if viewModel.isSearchActive && viewModel.searchText.isEmpty {
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
                        ForEach(viewModel.displayedMovies) { movie in
                            NavigationLink {
                                MovieDetailView(movie: movie, selectedDate: viewModel.selectedDate)
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
                if !viewModel.isSearchActive {
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.activateSearch()
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
        }
        .onReceive(sessionRefreshTimer) { now in
            viewModel.refreshCurrentTime(now)
        }
        .background(Color(.systemGroupedBackground))
    }

    // Shows the horizontal date filter.
    private var dateSelectorView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                allDatesButton

                ForEach(viewModel.dateOptions, id: \.self) { date in
                    dateButton(for: date)
                }
            }
        }
    }

    // Shows the search field and cancel button.
    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField("Search movies or genres", text: $viewModel.searchText)
                .autocorrectionDisabled()

            if !viewModel.searchText.isEmpty {
                Button {
                    viewModel.searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
            }

            Button("Cancel") {
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.cancelSearch()
                }
            }
            .foregroundStyle(.blue)
        }
    }

    // Shows the horizontal genre filter.
    private var genreFilterView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                filterButton(title: "All", isSelected: viewModel.selectedGenre == nil) {
                    viewModel.selectedGenre = nil
                }
                ForEach(MovieListViewModel.genreCategories, id: \.label) { category in
                    filterButton(title: category.label, isSelected: viewModel.selectedGenre == category.label) {
                        viewModel.selectedGenre = category.label
                    }
                }
            }
        }
    }

    // Selects all dates in the booking window.
    private var allDatesButton: some View {
        let isSelected = viewModel.selectedDate == nil

        return Button {
            viewModel.selectedDate = nil
        } label: {
            Text("All")
                .font(.caption.weight(.semibold))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 13)
                .padding(.vertical, 9)
                .background(isSelected ? Color.blue : Color(.systemGroupedBackground))
                .clipShape(Capsule())
                .shadow(color: .black.opacity(isSelected ? 0.12 : 0.04), radius: 4, x: 0, y: 2)
        }
    }

    // Builds one date filter button.
    private func dateButton(for date: Date) -> some View {
        let isSelected = viewModel.selectedDate.map {
            Calendar.current.isDate(date, inSameDayAs: $0)
        } ?? false

        return Button {
            viewModel.selectedDate = date
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

    // Formats the date label for the filter.
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

    // Builds one genre filter button.
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

    // Formats later dates in a short style.
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
