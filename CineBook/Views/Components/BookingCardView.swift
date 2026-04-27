//
//  BookingCardView.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import SwiftUI

struct BookingCardView: View {
    let booking: Booking
    let onCancel: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            headerView

            Divider()

            VStack(spacing: 9) {
                detailRow(title: "Reference", value: booking.referenceCode)
                detailRow(title: "Screen", value: booking.screenName)
                detailRow(title: "Seats", value: booking.seatText)
                detailRow(title: "Total", value: String(format: "$%.2f", booking.totalPrice))
            }

            Button(role: .destructive) {
                onCancel()
            } label: {
                Label("Cancel Booking", systemImage: "trash")
                    .font(.subheadline.weight(.semibold))
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .padding(.top, 4)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.08), radius: 7, x: 0, y: 4)
    }

    private var headerView: some View {
        HStack(alignment: .center, spacing: 18) {
            MoviePosterView(symbol: booking.posterSymbol, theme: booking.movieTheme)
                .frame(width: 72, height: 90)
                .clipped()

            VStack(alignment: .leading, spacing: 7) {
                HStack(spacing: 8) {
                    Text(booking.movieTitle)
                        .font(.headline)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)

                    Spacer(minLength: 0)
                }

                Text(booking.sessionTimeText)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

                Text("Confirmed")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.green)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 4)
                    .background(.green.opacity(0.12))
                    .clipShape(Capsule())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private func detailRow(title: String, value: String) -> some View {
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
}
