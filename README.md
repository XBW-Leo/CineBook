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

- Browse a catalogue of 8 movies spanning genres including Sci-Fi Thriller, Drama, Action Comedy, Animation, Spy Thriller, Romance, Adventure Comedy, and Mystery Drama
- Search movies by title or genre
- Filter movies by broad genre category: All, Action, Animation, Drama, Thriller
- View movie details including genre, duration, age rating, user rating, and summary
- View multiple sessions grouped by date (Today, Tomorrow, and future dates), sorted by start time
- Each session displays available seat count in real time
- Select seats using an interactive 5-row × 8-column seat map (rows A–E, seats 1–8)
- Select up to 8 seats per booking
- Prevent unavailable or already-booked seats from being selected
- Real-time duplicate booking protection: seats are re-validated at confirmation time
- Display selected seats and total ticket price before confirmation
- Confirm a booking and generate a unique 8-character booking reference code
- View a success screen with a "View My Bookings" shortcut after confirming
- View confirmed bookings split into Upcoming and Past sections
- Tab bar badge on My Bookings showing the total number of active bookings
- Cancel existing bookings with a confirmation prompt
- Persist bookings locally using UserDefaults and Codable

## iOS Frameworks and Technologies Used

### SwiftUI

SwiftUI is used to build the entire user interface, including navigation structure, tab bar, movie list, detail pages, seat selection screen, booking confirmation screen, and booking management page.

### Foundation

Foundation is used for core data types and utilities such as `Date`, `UUID`, `Calendar`, `DateFormatter`, and Codable data handling.

### Combine

Combine is used in `BookingStore` via `ObservableObject` and `@Published` to propagate booking state changes reactively to all views that depend on it.

### UserDefaults and Codable

UserDefaults and Codable are used to store confirmed bookings locally. This allows bookings to remain available after the app is closed and reopened. A custom `init(from:)` decoder ensures older saved bookings remain readable if the data model evolves.

### SF Symbols

SF Symbols are used throughout the app to provide consistent system icons for movies, tickets, seats, ratings, dates, and actions.

## Code Structure

The project is organised into clear functional sections. The main app code is located inside the `CineBook` folder:

```text
CineBook
├── CineBook.xcodeproj
├── CineBook
│   ├── Data
│   │   ├── MovieCatalog.swift       — static movie and session catalogue (8 movies)
│   │   └── SeatMapFactory.swift     — builds seat grids and sorts seat IDs
│   │
│   ├── Models
│   │   ├── Booking.swift            — confirmed booking with reference code helpers
│   │   ├── CinemaSession.swift      — session time, screen, price, pre-sold seats
│   │   ├── Movie.swift              — movie data and MovieTheme for poster colours
│   │   └── Seat.swift               — seat identity and availability status
│   │
│   ├── Stores
│   │   └── BookingStore.swift       — ObservableObject; add, cancel, persist bookings
│   │
│   ├── Views
│   │   ├── Bookings
│   │   │   └── MyBookingsView.swift — upcoming/past booking list with cancel action
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
│   └── ContentView.swift            — TabView with Movies and My Bookings tabs
│
├── .gitignore
└── README.md
```
