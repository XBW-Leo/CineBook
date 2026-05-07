//
//  SeatButtonView.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import SwiftUI

struct SeatButtonView: View {
    let seat: Seat
    let action: () -> Void

    // Shows one seat button.
    var body: some View {
        Button(action: action) {
            Text(seat.label)
                .font(.caption.weight(.bold))
                .foregroundStyle(textColor)
                .frame(height: 36)
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 9)
                        .strokeBorder(borderColor, lineWidth: seat.status == .selected ? 2 : 0)
                )
                .clipShape(RoundedRectangle(cornerRadius: 9))
                .scaleEffect(seat.status == .selected ? 1.04 : 1.0)
        }
        .disabled(seat.status == .unavailable)
        .animation(.spring(response: 0.22, dampingFraction: 0.75), value: seat.status)
        .accessibilityLabel("Seat \(seat.label)")
    }

    // Chooses the seat background color.
    private var backgroundColor: Color {
        switch seat.status {
        case .available:
            return .green.opacity(0.78)
        case .selected:
            return .blue
        case .unavailable:
            return Color(.systemGray5)
        }
    }

    // Chooses the seat border color.
    private var borderColor: Color {
        switch seat.status {
        case .selected:
            return .white.opacity(0.8)
        default:
            return .clear
        }
    }

    // Chooses the seat text color.
    private var textColor: Color {
        switch seat.status {
        case .available, .selected:
            return .white
        case .unavailable:
            return .secondary
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        SeatButtonView(seat: Seat(row: "A", number: 1, status: .available)) { }
        SeatButtonView(seat: Seat(row: "A", number: 2, status: .selected)) { }
        SeatButtonView(seat: Seat(row: "A", number: 3, status: .unavailable)) { }
    }
    .padding()
}
