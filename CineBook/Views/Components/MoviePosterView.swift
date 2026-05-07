//
//  MoviePosterView.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/27.
//

import SwiftUI

struct MoviePosterView: View {
    let symbol: String
    let theme: MovieTheme
    var cornerRadius: CGFloat = 18

    // Shows the styled movie poster.
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(
                    LinearGradient(
                        colors: theme.colors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            Circle()
                .fill(.white.opacity(0.16))
                .frame(width: 90, height: 90)
                .offset(x: 34, y: -38)

            Circle()
                .fill(.black.opacity(0.10))
                .frame(width: 70, height: 70)
                .offset(x: -38, y: 44)

            Image(systemName: symbol)
                .font(.system(size: 34, weight: .semibold))
                .foregroundStyle(.white)
        }
        // Clip the decorative shapes so they never overlap nearby text.
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

private extension MovieTheme {
    // Provides gradient colors for each movie theme.
    var colors: [Color] {
        switch self {
        case .midnight:
            return [.indigo, .purple]
        case .orchard:
            return [.green, .mint]
        case .fastLane:
            return [.red, .orange]
        case .ocean:
            return [.cyan, .blue]
        case .noir:
            return [.black, .gray]
        case .sunset:
            return [.pink, .orange]
        case .arcade:
            return [.purple, .blue]
        case .skyline:
            return [.teal, .indigo]
        }
    }
}

#Preview {
    MoviePosterView(symbol: "film", theme: .midnight)
        .frame(width: 160, height: 220)
        .padding()
}
