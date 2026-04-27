//
//  MovieCardView.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/27.
//

import SwiftUI

struct MovieCardView: View {
    let movie: Movie

    var body: some View {
        HStack(spacing: 15) {
            MoviePosterView(symbol: movie.posterSymbol, theme: movie.theme)
                .frame(width: 82, height: 112)

            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(2)

                Text(movie.genre)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                HStack(spacing: 9) {
                    Label(movie.durationText, systemImage: "clock")
                    Label(movie.ageRating, systemImage: "person.crop.circle")
                    Label(String(format: "%.1f", movie.userRating), systemImage: "star.fill")
                }
                .font(.caption)
                .foregroundStyle(.secondary)

                Text("\(movie.sessions.count) sessions available")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.blue)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
        }
        .padding(14)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}
