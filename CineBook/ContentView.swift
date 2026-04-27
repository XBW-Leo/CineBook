//
//  ContentView.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                MovieListView()
            }
            .tabItem {
                Label("Movies", systemImage: "film")
            }

            NavigationStack {
                MyBookingsView()
            }
            .tabItem {
                Label("My Bookings", systemImage: "ticket")
            }
        }
        .tint(.blue)
    }
}
