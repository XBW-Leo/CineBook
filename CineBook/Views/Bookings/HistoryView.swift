//
//  HistoryView.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject private var bookingStore: BookingStore
    @State private var showClearHistoryAlert = false

    var body: some View {
        Group {
            if bookingStore.pastBookings.isEmpty {
                emptyState
            } else {
                historyList
            }
        }
        .navigationTitle("History")
        .background(Color(.systemGroupedBackground))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if !bookingStore.pastBookings.isEmpty {
                    Button("Clear History") {
                        showClearHistoryAlert = true
                    }
                }
            }
        }
        .alert("Clear booking history?", isPresented: $showClearHistoryAlert) {
            Button("Clear History", role: .destructive) {
                bookingStore.clearHistoryBookings()
            }
            Button("Keep History", role: .cancel) { }
        } message: {
            Text("This will only remove expired bookings. Upcoming and active bookings will be kept.")
        }
    }

    private var historyList: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                ForEach(bookingStore.pastBookings) { booking in
                    BookingCardView(booking: booking, isUpcoming: false) { }
                }
            }
            .padding()
        }
    }

    private var emptyState: some View {
        VStack(spacing: 18) {
            Spacer()

            Image(systemName: "clock.arrow.circlepath")
                .font(.system(size: 58))
                .foregroundStyle(.blue)

            Text("No history bookings yet.")
                .font(.title2.bold())

            Text("Expired bookings will appear here after a session has ended.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        HistoryView()
    }
    .environmentObject(BookingStore())
}
