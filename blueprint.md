
# EcoSnap Blueprint

## Overview

EcoSnap is a mobile application designed to help users easily identify and classify waste for proper disposal and recycling. By leveraging a smartphone's camera and a machine learning model, the app can instantly recognize different types of waste and provide users with information on how to dispose of it responsibly.

## Implemented Features

*   **Firebase Integration:** The app is connected to a Firebase project.
*   **Camera Integration:** The app uses the device's camera to capture images of waste.
*   **UI Foundation:** The app has a basic UI structure with a landing screen and a camera screen.

## Current Plan

The previous goal of fixing the startup crash was successful, but it broke the application's navigation. The new plan is to restore all application functionality by implementing a robust navigation system.

### Steps:

1.  **Implement a Router:** Create a centralized routing system using the `go_router` package.
2.  **Define Routes:** Define routes for all existing screens:
    *   `/` (Landing Screen)
    *   `/login` (Login Screen)
    *   `/camera` (Waste Scanner Screen)
    *   `/results` (Results Screen)
    *   `/map` (Map Screen)
3.  **Integrate Router:** Connect the router to the main `MaterialApp` widget.
4.  **Verify Navigation:** Ensure all buttons and navigation actions correctly move the user between screens.
