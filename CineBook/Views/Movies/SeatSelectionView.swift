//
//  SeatSelectionView.swift
//  CineBook
//
//  Created by Lin Du on 2026/4/27.
//

import SwiftUI

struct SeatSelectionView: View {
    let movie: Movie
    let session: CinemaSession

    @EnvironmentObject private var bookingStore: BookingStore
    @State private var selectedSeatIDs: Set<String> = []
    @State private var showSeatAlert = false
    @State private var showMaxSeatAlert = false

    private let maxSeats = 8

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 8),
        count: SeatMapFactory.seatsPerRow
    )

    // Combines sold seats and already booked seats.
    private var unavailableSeatIDs: Set<String> {
        // Combine seats sold in the sample data with seats booked during app use.
        session.unavailableSeatIDs.union(bookingStore.bookedSeatIDs(for: session))
    }

    // Builds the seats shown in the grid.
    private var seats: [Seat] {
        SeatMapFactory.makeSeats(
            unavailableSeatIDs: unavailableSeatIDs,
            selectedSeatIDs: selectedSeatIDs
        )
    }

    // Sorts selected seats for display and booking.
    private var orderedSelectedSeatIDs: [String] {
        SeatMapFactory.sortedSeatIDs(Array(selectedSeatIDs))
    }

    // Calculates the total price for selected seats.
    private var totalPrice: Double {
        Double(selectedSeatIDs.count) * session.ticketPrice
    }

    // Shows the seat selection screen.
    var body: some View {
        ScrollView {
            VStack(spacing: 22) {
                headerCard
                screenView
                seatGridCard
                legendView
                summaryView
                continueButton
            }
            .padding()
            .padding(.bottom, 32)
        }
        .navigationTitle("Select Seats")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            removeUnavailableSelections()
        }
        .alert("Select at least one seat", isPresented: $showSeatAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please choose one or more available seats before continuing.")
        }
        .alert("Maximum seats reached", isPresented: $showMaxSeatAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("You can select up to \(maxSeats) seats per booking.")
        }
    }

    // Shows the selected movie and session summary.
    private var headerCard: some View {
        HStack(spacing: 14) {
            MoviePosterView(symbol: movie.posterSymbol, theme: movie.theme)
                .frame(width: 70, height: 92)

            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title)
                    .font(.headline)

                Text(session.startTimeText)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(session.screenName)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.blue)
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 3)
    }

    // Shows the cinema screen indicator.
    private var screenView: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 8)
                .fill(
                    LinearGradient(
                        colors: [.gray.opacity(0.35), .gray.opacity(0.12)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: 14)
                .padding(.horizontal, 36)

            Text("SCREEN")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
        }
        .padding(.top, 4)
    }

    // Shows the seat grid.
    private var seatGridCard: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(seats) { seat in
                SeatButtonView(seat: seat) {
                    toggleSeat(seat)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 3)
    }

    // Shows the meaning of seat colors.
    private var legendView: some View {
        HStack(spacing: 16) {
            legendItem(color: .green, text: "Available")
            legendItem(color: .blue, text: "Selected")
            legendItem(color: .gray, text: "Unavailable")
        }
        .font(.caption)
        .foregroundStyle(.secondary)
    }

    // Builds one legend item.
    private func legendItem(color: Color, text: String) -> some View {
        HStack(spacing: 6) {
            Circle()
                .fill(color.opacity(0.8))
                .frame(width: 10, height: 10)

            Text(text)
        }
    }

    // Shows selected seats and price summary.
    private var summaryView: some View {
        VStack(spacing: 11) {
            HStack {
                Text("Selected Seats")
                    .font(.headline)

                Spacer()

                Text(orderedSelectedSeatIDs.isEmpty ? "None" : orderedSelectedSeatIDs.joined(separator: ", "))
                    .foregroundStyle(.secondary)
            }

            HStack {
                Text("Ticket Price")
                    .foregroundStyle(.secondary)

                Spacer()

                Text(String(format: "$%.2f", session.ticketPrice))
                    .foregroundStyle(.secondary)
            }

            Divider()

            HStack {
                Text("Total")
                    .font(.headline)

                Spacer()

                Text(String(format: "$%.2f", totalPrice))
                    .font(.headline)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 3)
    }

    // Shows the continue action for booking.
    private var continueButton: some View {
        HStack {
            Spacer(minLength: 0)
            Group {
                if selectedSeatIDs.isEmpty {
                    Button {
                        showSeatAlert = true
                    } label: {
                        buttonLabel("Continue")
                    }
                } else {
                    NavigationLink {
                        BookingConfirmationView(
                            movie: movie,
                            session: session,
                            selectedSeatIDs: orderedSelectedSeatIDs
                        )
                    } label: {
                        buttonLabel("Continue")
                    }
                    .buttonStyle(.plain)
                }
            }
            Spacer(minLength: 0)
        }
    }

    // Builds the main button style.
    private func buttonLabel(_ title: String) -> some View {
        Text(title)
            .font(.headline)
            .foregroundStyle(.white)
            .padding(.vertical, 14)
            .padding(.horizontal, 48)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }

    // Selects or deselects an available seat.
    private func toggleSeat(_ seat: Seat) {
        guard seat.status != .unavailable else { return }

        if selectedSeatIDs.contains(seat.id) {
            selectedSeatIDs.remove(seat.id)
        } else {
            guard selectedSeatIDs.count < maxSeats else {
                showMaxSeatAlert = true
                return
            }
            selectedSeatIDs.insert(seat.id)
        }
    }

    private func removeUnavailableSelections() {
        // If a seat becomes unavailable while navigating back and forth,
        // remove it from the local selection before continuing.
        selectedSeatIDs.subtract(unavailableSeatIDs)
    }
}

#Preview {
    NavigationStack {
        SeatSelectionView(
            movie: MovieCatalog.movies[0],
            session: MovieCatalog.movies[0].sessions[0]
        )
    }
    .environmentObject(BookingStore())
}
