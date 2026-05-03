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
        HStack(spacing: 0) {
            MoviePosterView(symbol: movie.posterSymbol, theme: movie.theme)
                .frame(width: 68, height: 90)
                .padding(.leading, 6)

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
            .padding(.leading, 26)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
        }
        .padding(14)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 3)
    }
}

#Preview {
    MovieCardView(movie: MovieCatalog.movies[0])
        .padding()
        .background(Color(.systemGroupedBackground))
}
