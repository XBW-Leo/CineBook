//
//  SessionRowView.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import SwiftUI

struct SessionRowView: View {
    let session: CinemaSession
    let availableSeats: Int

    private var isSoldOut: Bool { availableSeats == 0 }

    private var dayText: String {
        Self.dayFormatter.string(from: session.startsAt).uppercased()
    }

    private var dateText: String {
        Self.dateFormatter.string(from: session.startsAt)
    }

    private var timeText: String {
        Self.timeFormatter.string(from: session.startsAt)
    }

    var body: some View {
        HStack(spacing: 14) {
            VStack(spacing: 4) {
                Text(dayText)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(isSoldOut ? Color.gray : Color.blue)

                Text(dateText)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            .frame(width: 62)
            .padding(.vertical, 10)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 14))

            VStack(alignment: .leading, spacing: 5) {
                Text(timeText)
                    .font(.headline)
                    .foregroundStyle(isSoldOut ? .secondary : .primary)

                Text(session.screenName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 5) {
                Text(String(format: "$%.2f", session.ticketPrice))
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(isSoldOut ? .secondary : .primary)

                if isSoldOut {
                    Text("Sold Out")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.red)
                } else {
                    Text("\(availableSeats) seats left")
                        .font(.caption)
                        .foregroundStyle(availableSeats <= 5 ? .orange : .green)
                }
            }

            Image(systemName: isSoldOut ? "nosign" : "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 3)
        .opacity(isSoldOut ? 0.55 : 1.0)
    }

    private static let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        return formatter
    }()

    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
}

#Preview {
    VStack(spacing: 14) {
        SessionRowView(session: MovieCatalog.movies[0].sessions[0], availableSeats: 24)
        SessionRowView(session: MovieCatalog.movies[0].sessions[1], availableSeats: 0)
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
