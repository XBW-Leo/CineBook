# CineBook

CineBook is a SwiftUI-based iOS cinema booking application developed as a minimum viable product for the iOS Application Development group assignment. The app allows users to browse movies, view available sessions across multiple days, select seats, confirm bookings, and manage or cancel existing bookings.

## Project Overview

CineBook focuses on simplifying the cinema booking experience for mobile users. Instead of requiring users to move through a complex booking process, the app provides a clear flow from movie discovery to seat selection and booking management.

The main booking flow is:

Movies → Movie Detail → Session Selection → Seat Selection → Booking Confirmation → My Bookings

## Target Audience

The target audience is university students and young adults who regularly watch movies with friends and prefer a fast, mobile-first way to book cinema seats. These users value clear session information, simple seat selection, and the ability to manage bookings without needing to visit a cinema counter or use a complicated website.

## Problem Statement

Cinema booking can become inconvenient when users need to compare movies, check available sessions, select seats, and manage reservations through separate or cluttered interfaces. CineBook addresses this problem by combining these steps into one simple iOS app with a focused and easy-to-follow booking process.

## Key Features

- Browse a catalogue of movies
- Search movies by title or genre
- Filter movies by genre
- View movie details, including genre, duration, rating, and summary
- View multiple sessions across today, tomorrow, and future dates
- Select seats using an interactive seat map
- Prevent unavailable or already booked seats from being selected
- Display selected seats and total ticket price before confirmation
- Confirm a booking and generate a booking reference
- View confirmed bookings
- Cancel existing bookings
- Persist bookings locally using UserDefaults and Codable

## iOS Frameworks and Technologies Used

### SwiftUI

SwiftUI is used to build the user interface, navigation structure, movie list, detail pages, seat selection screen, booking confirmation screen, and booking management page.

### Foundation

Foundation is used for core data types and utilities such as `Date`, `UUID`, `Calendar`, `DateFormatter`, and Codable data handling.

### UserDefaults and Codable

UserDefaults and Codable are used to store confirmed bookings locally. This allows bookings to remain available after the app is closed and reopened.

### SF Symbols

SF Symbols are used throughout the app to provide consistent system icons for movies, tickets, seats, ratings, dates, and actions.

## Code Structure

The project is organised into clear functional sections. The main app code is located inside the `CineBook` folder:

```text
CineBook
├── CineBook.xcodeproj
├── CineBook
│   ├── Data
│   │   ├── MovieCatalog.swift
│   │   └── SeatMapFactory.swift
│   │
│   ├── Models
│   │   ├── Booking.swift
│   │   ├── CinemaSession.swift
│   │   ├── Movie.swift
│   │   └── Seat.swift
│   │
│   ├── Stores
│   │   └── BookingStore.swift
│   │
│   ├── Views
│   │   ├── Bookings
│   │   │   └── MyBookingsView.swift
│   │   │
│   │   ├── Components
│   │   │   ├── BookingCardView.swift
│   │   │   ├── MovieCardView.swift
│   │   │   ├── MoviePosterView.swift
│   │   │   ├── SeatButtonView.swift
│   │   │   └── SessionRowView.swift
│   │   │
│   │   └── Movies
│   │       ├── BookingConfirmationView.swift
│   │       ├── MovieDetailView.swift
│   │       ├── MovieListView.swift
│   │       └── SeatSelectionView.swift
│   │
│   ├── Assets.xcassets
│   ├── CineBookApp.swift
│   └── ContentView.swift
│
├── .gitignore
└── README.md

