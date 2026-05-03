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
    @State private var moviesResetID = UUID()

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                MovieListView()
            }
            .id(moviesResetID)
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
            .badge(bookingStore.upcomingBookings.count)
            .tag(1)

            NavigationStack {
                HistoryView()
            }
            .tabItem {
                Label("History", systemImage: "clock.arrow.circlepath")
            }
            .tag(2)
        }
        .tint(.blue)
        .onChange(of: selectedTab) { _, newTab in
            if newTab == 0 {
                moviesResetID = UUID()
            }
        }
        .onChange(of: bookingStore.pendingTabSwitch) { _, newTab in
            if let tab = newTab {
                selectedTab = tab
                bookingStore.pendingTabSwitch = nil
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(BookingStore())
}
