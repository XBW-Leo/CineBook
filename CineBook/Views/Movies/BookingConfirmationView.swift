//
//  BookingConfirmationView.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/27.
//

import SwiftUI

struct BookingConfirmationView: View {
    let movie: Movie
    let session: CinemaSession
    let selectedSeatIDs: [String]

    @EnvironmentObject private var bookingStore: BookingStore

    @State private var confirmedBooking: Booking?
    @State private var showBookingError = false

    private var totalPrice: Double {
        Double(selectedSeatIDs.count) * session.ticketPrice
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 22) {
                if let confirmedBooking {
                    successView(for: confirmedBooking)
                } else {
                    confirmationSummary
                }
            }
            .padding()
        }
        .navigationTitle("Confirm Booking")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
        .toolbar(.hidden, for: .tabBar)
        .alert("Booking could not be completed", isPresented: $showBookingError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("One or more selected seats may no longer be available. Please go back and choose again.")
        }
    }

    private var confirmationSummary: some View {
        VStack(alignment: .leading, spacing: 18) {
            posterHeader

            VStack(spacing: 12) {
                summaryRow(title: "Movie", value: movie.title)
                summaryRow(title: "Session", value: session.startTimeText)
                summaryRow(title: "Cinema", value: session.screenName)
                summaryRow(title: "Seats", value: selectedSeatIDs.joined(separator: ", "))
                summaryRow(title: "Ticket Price", value: String(format: "$%.2f", session.ticketPrice))
                summaryRow(title: "Total", value: String(format: "$%.2f", totalPrice))
            }
            .padding()
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))

            Button {
                confirmBooking()
            } label: {
                Text("Confirm Booking")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .padding(.top, 4)
        }
    }

    private var posterHeader: some View {
        HStack(spacing: 14) {
            MoviePosterView(symbol: movie.posterSymbol, theme: movie.theme)
                .frame(width: 88, height: 116)

            VStack(alignment: .leading, spacing: 7) {
                Text(movie.title)
                    .font(.title2.bold())

                Text(movie.genre)
                    .foregroundStyle(.secondary)

                Label(movie.durationText, systemImage: "clock")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func summaryRow(title: String, value: String) -> some View {
        HStack(alignment: .top) {
            Text(title)
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
                .fontWeight(.medium)
                .multilineTextAlignment(.trailing)
        }
        .font(.subheadline)
    }

    private func successView(for booking: Booking) -> some View {
        VStack(spacing: 18) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 72))
                .foregroundStyle(.green)

            Text("Booking Confirmed")
                .font(.title.bold())

            Text("Reference: \(booking.referenceCode)")
                .font(.headline)
                .foregroundStyle(.secondary)

            VStack(spacing: 12) {
                summaryRow(title: "Movie", value: booking.movieTitle)
                summaryRow(title: "Session", value: booking.sessionTimeText)
                summaryRow(title: "Seats", value: booking.seatText)
                summaryRow(title: "Total", value: String(format: "$%.2f", booking.totalPrice))
            }
            .padding()
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))

            Text("You can view or cancel this booking from the My Bookings tab.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button {
                bookingStore.pendingTabSwitch = 1
            } label: {
                Text("View My Bookings")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
        }
    }

    private func confirmBooking() {
        let booking = bookingStore.addBooking(
            movie: movie,
            session: session,
            selectedSeatIDs: selectedSeatIDs
        )

        if let booking {
            confirmedBooking = booking
        } else {
            showBookingError = true
        }
    }
}

#Preview {
    NavigationStack {
        BookingConfirmationView(
            movie: MovieCatalog.movies[0],
            session: MovieCatalog.movies[0].sessions[0],
            selectedSeatIDs: ["A1", "A2"]
        )
    }
    .environmentObject(BookingStore())
}
