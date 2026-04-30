//
//  ContentView.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var bookingStore: BookingStore
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                MovieListView()
            }
            .tabItem {
                Label("Movies", systemImage: "film")
            }
            .tag(0)

            NavigationStack {
                MyBookingsView(selectedTab: $selectedTab)
            }
            .tabItem {
                Label("My Bookings", systemImage: "ticket")
            }
            .badge(bookingStore.bookings.count)
            .tag(1)
        }
        .tint(.blue)
        .onChange(of: bookingStore.pendingTabSwitch) { _, newTab in
            if let tab = newTab {
                selectedTab = tab
                bookingStore.pendingTabSwitch = nil
            }
        }
    }
}
