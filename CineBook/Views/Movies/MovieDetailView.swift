//
//  MovieDetailView.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    let selectedDate: Date

    @EnvironmentObject private var bookingStore: BookingStore

    private let totalSeats = SeatMapFactory.rows.count * SeatMapFactory.seatsPerRow

    private func availableSeats(for session: CinemaSession) -> Int {
        let taken = session.unavailableSeatIDs.union(bookingStore.bookedSeatIDs(for: session))
        return max(0, totalSeats - taken.count)
    }

    private var groupedSessions: [(date: Date, sessions: [CinemaSession])] {
        // Grouping sessions by day makes the booking flow easier to scan.
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: movie.sessions) { session in
            calendar.startOfDay(for: session.startsAt)
        }

        return grouped.keys
            .filter { calendar.isDate($0, inSameDayAs: selectedDate) }
            .sorted()
            .map { date in
                let sessions = grouped[date]?
                    .filter { calendar.isDate($0.startsAt, inSameDayAs: selectedDate) }
                    .sorted { $0.startsAt < $1.startsAt } ?? []
                return (date, sessions)
            }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                posterView
                movieInfoView
                overviewView
                sessionSection
            }
            .padding()
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }

    private var posterView: some View {
        ZStack(alignment: .bottomLeading) {
            MoviePosterView(symbol: movie.posterSymbol, theme: movie.theme, cornerRadius: 28)
                .frame(height: 250)

            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title)
                    .font(.title.bold())

                Text(movie.genre)
                    .font(.headline)
                    .opacity(0.9)
            }
            .foregroundStyle(.white)
            .padding(22)
        }
    }

    private var movieInfoView: some View {
        HStack(spacing: 10) {
            infoPill(icon: "clock", text: movie.durationText)
            infoPill(icon: "person.crop.circle", text: movie.ageRating)
            infoPill(icon: "star.fill", text: String(format: "%.1f", movie.userRating))

            Spacer()
        }
    }

    private var overviewView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Overview")
                .font(.headline)

            Text(movie.summary)
                .font(.body)
                .foregroundStyle(.secondary)
                .lineSpacing(3)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }

    private var sessionSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Available Sessions")
                .font(.headline)

            ForEach(groupedSessions, id: \.date) { group in
                VStack(alignment: .leading, spacing: 10) {
                    Text(sectionTitle(for: group.date))
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.secondary)
                        .padding(.leading, 2)

                    ForEach(group.sessions) { session in
                        let seats = availableSeats(for: session)
                        if seats > 0 {
                            NavigationLink {
                                SeatSelectionView(movie: movie, session: session)
                            } label: {
                                SessionRowView(session: session, availableSeats: seats)
                            }
                            .buttonStyle(.plain)
                        } else {
                            SessionRowView(session: session, availableSeats: 0)
                        }
                    }
                }
            }
        }
    }

    private func infoPill(icon: String, text: String) -> some View {
        Label(text, systemImage: icon)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 11)
            .padding(.vertical, 8)
            .background(Color(.systemBackground))
            .clipShape(Capsule())
    }

    private func sectionTitle(for date: Date) -> String {
        let calendar = Calendar.current

        if calendar.isDateInToday(date) {
            return "Today"
        }

        if calendar.isDateInTomorrow(date) {
            return "Tomorrow"
        }

        return Self.dateSectionFormatter.string(from: date)
    }

    private static let dateSectionFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMM"
        return formatter
    }()
}

#Preview {
    NavigationStack {
        MovieDetailView(movie: MovieCatalog.movies[0], selectedDate: Date())
    }
    .environmentObject(BookingStore())
}
