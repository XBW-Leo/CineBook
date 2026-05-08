# 42889 iOS Application Development – Assessment 3

## CineBook

**CineBook** is a SwiftUI-based iOS cinema booking application developed as a minimum viable product for the iOS Application Development group project. The app allows users to browse movies, choose sessions across multiple dates, select seats, confirm bookings, view booking history, and cancel upcoming bookings.

## Group Members

| Student ID | Name |
|---|---|
| 25546235 | Lin Du |
| 25605344 | Xuebin Wu |
| 25942689 | Xinyu Zhou |

## Project Overview

CineBook focuses on simplifying the cinema booking experience for mobile users. Instead of requiring users to move through a complicated website or visit a cinema counter, the app provides a clear native iOS flow from movie discovery to seat selection and booking management.

Compared with booking at a cinema counter or using a complex website, CineBook gives users one simple mobile flow for browsing movies, choosing seats, and managing bookings.

The main user flow is:

Movies → Movie Detail → Session Selection → Seat Selection → Booking Confirmation → My Bookings → History

## Target Audience

The target audience is university students and young adults aged 18–35 who regularly watch movies with friends and prefer a fast, mobile-first booking experience. These users value clear session information, simple seat selection, visible seat availability, and the ability to manage bookings without needing to call the cinema or use a cluttered website.

## Problem Statement

Cinema booking can be inconvenient when users need to compare movies, check sessions across dates, select seats, manage reservations, and cancel bookings through separate or poorly optimised interfaces. CineBook addresses this problem by combining these steps into one focused iOS app with a simple booking flow and clear seat availability feedback.

## Key Features

- Browse a catalogue of 8 movies across multiple genres
- Select all dates or one date across a 7-day booking window
- Search movies by title or genre
- Filter movies by broad genre category: All, Action, Animation, Drama, and Thriller
- View movie details including genre, duration, age rating, user rating, and summary
- View available sessions sorted by date and time
- Hide expired sessions automatically and prevent bookings after a session has started
- Display real-time available seat count for each session
- Show sold-out sessions clearly when no seats are available
- Select seats using an interactive 5-row × 8-column seat map
- Limit each booking to a maximum of 8 seats
- Prevent unavailable or already-booked seats from being selected
- Recheck seat availability before confirmation to prevent duplicate bookings
- Display selected seats and total ticket price before confirmation
- Confirm a booking and generate an 8-character booking reference code
- Generate a QR code for each confirmed booking
- View upcoming bookings in the My Bookings tab
- Display a tab badge showing the number of upcoming bookings
- Cancel upcoming bookings with a confirmation alert
- Move expired bookings into the History tab
- Clear past booking history with a confirmation alert and without affecting upcoming bookings
- Persist bookings locally using UserDefaults and Codable

## iOS Frameworks and Technologies Used

### SwiftUI

SwiftUI is used to build the main user interface, including the tab bar, navigation stacks, movie list, movie detail page, seat selection screen, booking confirmation screen, My Bookings page, and History page.

### Foundation

Foundation is used for core data types and utilities such as `Date`, `UUID`, `Calendar`, `DateFormatter`, and Codable data handling.

### Combine

Combine is used through `ObservableObject` and `@Published` in `BookingStore`, allowing booking state changes to update related views automatically.

### UserDefaults and Codable

UserDefaults and Codable are used to store confirmed bookings locally. This allows bookings to remain available after the app is closed and reopened.

### CoreImage

CoreImage is used to generate QR codes for confirmed bookings based on the booking reference code.

### SF Symbols

SF Symbols are used throughout the interface to provide consistent system icons for movies, tickets, seats, ratings, dates, search, history, and booking actions.

## Code Structure

The project is organised into clear functional sections. The main app code is located inside the `CineBook` folder:

```text
CineBook
├── CineBook.xcodeproj
├── CineBook
│   ├── App
│   │   └── CineBookApp.swift
│   │
│   ├── Models
│   │   ├── Booking.swift
│   │   ├── CinemaSession.swift
│   │   ├── Movie.swift
│   │   ├── MovieCatalog.swift
│   │   ├── Seat.swift
│   │   └── SeatMapFactory.swift
│   │
│   ├── ViewModels
│   │   ├── BookingStore.swift
│   │   └── MovieListViewModel.swift
│   │
│   ├── Views
│   │   ├── Bookings
│   │   │   ├── HistoryView.swift
│   │   │   └── MyBookingsView.swift
│   │   │
│   │   ├── Components
│   │   │   ├── BookingCardView.swift
│   │   │   ├── MovieCardView.swift
│   │   │   ├── MoviePosterView.swift
│   │   │   ├── SeatButtonView.swift
│   │   │   └── SessionRowView.swift
│   │   │
│   │   ├── Movies
│   │   │   ├── BookingConfirmationView.swift
│   │   │   ├── MovieDetailView.swift
│   │   │   ├── MovieListView.swift
│   │   │   └── SeatSelectionView.swift
│   │   │
│   │   └── ContentView.swift
│   │
│   └── Assets.xcassets
│
├── .gitignore
└── README.md
```

## Code Design

### Data Modelling

The app uses separate data models for `Movie`, `CinemaSession`, `Seat`, and `Booking`. These models reflect the main entities in a cinema booking system and keep the app logic easier to understand and maintain.

### Immutable Data and Safer State

Most domain data is represented using Swift `struct` types and `let` constants. Seat availability is controlled through the `SeatStatus` enum, which helps prevent invalid seat states from being created accidentally.

### Functional Separation

The project separates app entry setup, data models, sample catalogue data, booking state management, movie list filtering, and reusable SwiftUI components. For example, movie and session content is stored in `MovieCatalog`, seat grid generation is handled by `SeatMapFactory`, movie list search/date/genre filtering is handled by `MovieListViewModel`, and booking persistence is managed by `BookingStore`.

### Loose Coupling

Views do not directly manage persistent storage. Booking-related logic is handled by `BookingStore`, movie list filtering is handled by `MovieListViewModel`, while UI screens focus on presentation and user interaction. This makes each part easier to modify without affecting unrelated files.

### Extensibility

New movies, sessions, prices, screens, unavailable seats, and movie themes can be added mainly by updating the model and catalogue data. The main UI does not need to be rewritten when new movie content is added.

The current catalogue uses relative session dates, so sessions can stay within the next 7 days without using fixed calendar dates.

### Error Handling and User Guidance

The app prevents invalid booking actions by:

- Disabling unavailable seats
- Preventing users from continuing without selecting a seat
- Limiting each booking to 8 seats
- Showing an alert when the maximum seat limit is reached
- Rechecking seat availability at confirmation time
- Hiding sessions that have already started
- Preventing users from confirming bookings for expired sessions
- Marking sold-out sessions clearly
- Asking for confirmation before cancelling a booking
- Asking for confirmation before clearing booking history
- Keeping active/upcoming and past bookings separated

## How to Run the Project

1. Open `CineBook.xcodeproj` in Xcode.
2. Select an iOS Simulator.
3. Build and run the project using `Command + R`.
4. Use the Movies tab to browse films, select a date, choose a session, and make a booking.
5. Use the My Bookings tab to view or cancel upcoming bookings.
6. Use the History tab to view expired bookings.

## GitHub Repository

GitHub Repository Link:

https://github.com/XBW-Leo/CineBook

## Minimum Viable Product and Iterative Design

CineBook was developed as an MVP through an iterative product design process.

The first version focused on the core booking flow: displaying movies, choosing a session, selecting seats, and confirming a booking. Later iterations added local persistence, cancellation, improved seat availability handling, a larger movie catalogue, date-based session browsing, search, genre filtering, QR code generation, booking history, and a more polished user interface.

This iterative process helped keep the app focused on the core user problem while gradually improving usability and code quality.

## Greatest Development Challenge

The greatest challenge was managing seat availability consistently across the booking process. A seat could be unavailable from the sample cinema data, selected by the current user, or already booked in a previous confirmed booking.

To solve this, the project uses `SeatStatus` to represent seat state, `SeatMapFactory` to generate the seat grid, and `BookingStore` to recheck availability before confirming a booking. This prevents duplicate bookings and guides users toward valid actions.

## Current Limitations

CineBook is an MVP and uses local sample data rather than a live cinema database. Payment processing, user login, real cinema APIs, online accounts, and cloud synchronisation are outside the current project scope but could be added in future versions.
