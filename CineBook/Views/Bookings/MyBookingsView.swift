//
//  MyBookingsView.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import SwiftUI

struct MyBookingsView: View {
    @EnvironmentObject private var bookingStore: BookingStore

    @State private var bookingToCancel: Booking?
    @State private var showCancelDialog = false

    var body: some View {
        Group {
            if bookingStore.hasBookings {
                bookingList
            } else {
                emptyState
            }
        }
        .navigationTitle("My Bookings")
        .background(Color(.systemGroupedBackground))
        .confirmationDialog(
            "Cancel this booking?",
            isPresented: $showCancelDialog,
            titleVisibility: .visible
        ) {
            Button("Cancel Booking", role: .destructive) {
                if let bookingToCancel {
                    bookingStore.cancelBooking(bookingToCancel)
                    self.bookingToCancel = nil
                }
            }

            Button("Keep Booking", role: .cancel) {
                bookingToCancel = nil
            }
        } message: {
            Text("This action will remove the booking from your list.")
        }
    }

    private var bookingList: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                summaryHeader

                LazyVStack(spacing: 14) {
                    ForEach(bookingStore.recentBookings) { booking in
                        BookingCardView(booking: booking) {
                            bookingToCancel = booking
                            showCancelDialog = true
                        }
                    }
                }
            }
            .padding()
        }
    }

    private var summaryHeader: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Upcoming Bookings")
                .font(.title2.bold())

            HStack(spacing: 12) {
                summaryTile(
                    title: "\(bookingStore.bookings.count)",
                    subtitle: "Bookings",
                    icon: "ticket"
                )

                summaryTile(
                    title: "\(bookingStore.totalSeatsBooked)",
                    subtitle: "Seats",
                    icon: "chair"
                )

                summaryTile(
                    title: String(format: "$%.2f", bookingStore.totalSpent),
                    subtitle: "Total",
                    icon: "creditcard"
                )
            }
        }
    }

    private func summaryTile(title: String, subtitle: String, icon: String) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.headline)
                .foregroundStyle(.blue)

            Text(title)
                .font(.headline)
                .lineLimit(1)
                .minimumScaleFactor(0.7)

            Text(subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 3)
    }

    private var emptyState: some View {
        VStack(spacing: 18) {
            Image(systemName: "ticket")
                .font(.system(size: 58))
                .foregroundStyle(.blue)

            Text("No Bookings Yet")
                .font(.title2.bold())

            Text("Choose a movie, select a session, and your confirmed bookings will appear here.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Text("Start from the Movies tab")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.blue)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(.blue.opacity(0.10))
                .clipShape(Capsule())
        }
        .padding()
    }
}
