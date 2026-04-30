//
//  MyBookingsView.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import SwiftUI

struct MyBookingsView: View {
    @EnvironmentObject private var bookingStore: BookingStore
    @Binding var selectedTab: Int

    @State private var bookingToCancel: Booking?
    @State private var showCancelAlert = false

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
        .alert("Cancel this booking?", isPresented: $showCancelAlert) {
            Button("Cancel Booking", role: .destructive) {
                if let booking = bookingToCancel {
                    bookingStore.cancelBooking(booking)
                    bookingToCancel = nil
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
            VStack(alignment: .leading, spacing: 24) {
                if !bookingStore.upcomingBookings.isEmpty {
                    sectionView(
                        title: "Upcoming",
                        bookings: bookingStore.upcomingBookings,
                        isUpcoming: true
                    )
                }

                if !bookingStore.pastBookings.isEmpty {
                    sectionView(
                        title: "Past",
                        bookings: bookingStore.pastBookings,
                        isUpcoming: false
                    )
                }
            }
            .padding()
        }
    }

    private func sectionView(title: String, bookings: [Booking], isUpcoming: Bool) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(title)
                .font(.title3.bold())

            ForEach(bookings) { booking in
                BookingCardView(booking: booking, isUpcoming: isUpcoming) {
                    bookingToCancel = booking
                    showCancelAlert = true
                }
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 18) {
            Spacer()

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

            Button {
                selectedTab = 0
            } label: {
                Text("Browse Movies")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(.blue)
                    .clipShape(Capsule())
            }

            Spacer()
        }
        .padding()
    }
}
