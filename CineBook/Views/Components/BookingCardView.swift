//
//  BookingCardView.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct BookingCardView: View {
    let booking: Booking
    let isUpcoming: Bool
    let onCancel: () -> Void

    private var truncatedSeatText: String {
        let seats = booking.seatIDs
        if seats.count <= 6 {
            return seats.joined(separator: ", ")
        }
        let preview = seats.prefix(3).joined(separator: ", ")
        return "\(preview) (+\(seats.count - 3) more)"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView
            Divider()
            qrSection
            Divider()
            detailSection
            if isUpcoming {
                Divider()
                cancelButton
            }
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 3)
    }

    private var headerView: some View {
        HStack(alignment: .center, spacing: 0) {
            MoviePosterView(symbol: booking.posterSymbol, theme: booking.movieTheme)
                .frame(width: 68, height: 90)
                .padding(.leading, 6)

            VStack(alignment: .leading, spacing: 6) {
                Text(booking.movieTitle)
                    .font(.headline)
                    .lineLimit(2)

                Text(booking.sessionTimeText)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(booking.screenName)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(isUpcoming ? "Upcoming" : "Past")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(isUpcoming ? .green : .secondary)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 4)
                    .background(isUpcoming ? .green.opacity(0.12) : Color(.systemGray6))
                    .clipShape(Capsule())
            }
            .padding(.leading, 26)

            Spacer()
        }
        .padding(14)
    }

    private var qrSection: some View {
        HStack(spacing: 16) {
            Image(uiImage: generateQRCode(from: booking.referenceCode))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text("Entry QR Code")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(booking.referenceCode)
                    .font(.title3.bold().monospaced())

                Text("Present at cinema entry")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding()
    }

    private var detailSection: some View {
        VStack(spacing: 10) {
            detailRow(title: "Screen", value: booking.screenName)
            detailRow(title: "Seats", value: truncatedSeatText)
            detailRow(title: "Total", value: String(format: "$%.2f", booking.totalPrice))
        }
        .padding()
    }

    private var cancelButton: some View {
        Button(role: .destructive) {
            onCancel()
        } label: {
            Label("Cancel Booking", systemImage: "trash")
                .font(.subheadline.weight(.semibold))
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
        .padding()
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

    private func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(string.utf8)
        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        return UIImage(systemName: "qrcode") ?? UIImage()
    }
}
