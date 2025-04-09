# Yum Gott App

A TikTok-style food video sharing app where users can browse food videos, order food, and earn cashback by sharing their own food videos.

## Features

- TikTok-style vertical video feed for food content
- Restaurant and dish discovery
- User authentication (login, register, guest mode)
- Order food directly from videos
- Share food videos and earn cashback

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Android Studio / Xcode for emulators
- A physical device or emulator

### Installation

1. Clone the repository
2. Navigate to the project directory
3. Run `flutter pub get` to install dependencies
4. Add sample videos to the `assets/videos/` directory (see placeholders.txt for details)
5. Run the app with `flutter run`

### Sample Videos

For testing purposes, you need to add sample videos to the `assets/videos/` directory:

1. video1.mp4 - Burger video
2. video2.mp4 - Pizza video
3. video3.mp4 - Sushi video
4. video4.mp4 - Tacos video
5. video5.mp4 - Dessert video

You can use any free stock videos for these placeholders. The videos should be short (10-15 seconds) and show the food items in an appealing way.

## App Structure

The app follows a feature-based architecture:

- `lib/core/` - Core utilities, constants, and theme
- `lib/features/` - Feature modules
  - `auth/` - Authentication (login, register)
  - `feed/` - Video feed (TikTok-style)
  - `home/` - Home screen
  - `onboarding/` - Onboarding screens
  - `product/` - Product details
  - `restaurant/` - Restaurant details
  - `search/` - Search functionality
  - `cart/` - Shopping cart
  - `profile/` - User profile

## Usage

1. Launch the app
2. Complete the onboarding process or skip it
3. Browse food videos by swiping up and down
4. Interact with videos (like, comment, share)
5. Order food directly from videos
6. Create an account to share your own food videos

## Screenshots

(Add screenshots here once the app is running)
