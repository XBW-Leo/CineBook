//
//  CineBookApp.swift
//  CineBook
//
//  Created by Xuebin Wu on 2026/4/26.
//

import SwiftUI

@main
struct CineBookApp: App {
    @StateObject private var bookingStore = BookingStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bookingStore)
        }
    }
}
