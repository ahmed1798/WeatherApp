# WeatherApp

This is a Swift application that fetches and displays the weather details of city. The application is structured using the MVVM-C archeticture pattern and includes features such as weather details.

## Features

- Fetches the weather detailsfrom API.
- Displays a weather details by searching city name and the app cache the data of searching instead of calling the api again.
- Display a 5-day weather forecast, with daily temperature highs and lows.
- Uses the MVVM-C architecture for clean and maintainable code.

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.0+

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/ahmed1798/WeatherApp
    ```
2. Open the project in Xcode:
    ```sh
    cd WeatherApp
    open WeatherApp.xcodeproj
    ```

## Usage

1. Replace the placeholder API key in `WeatherNetworkService.swift` with your valid Weather API key:
    ```swift
    private let apiKey = "your-valid-api-key" // Replace with your valid API key
    ```

2. Build and run the project on the simulator or a physical device.

## Project Structure

The project follows the MVVM (Model-View-ViewModel) design pattern:

- **Domain Layer**: Contains Repository Interface, UseCase and entities. 
- **Data Layer**: Contains RepositoryImplementation and Network. 
- **Presentation Layer**: Contains view models and views.

## Unit Testing

The project includes unit tests to ensure the functionality of the network layer and view models:

1. Open the Test navigator in Xcode (⌘ + 6).
2. Run the tests by pressing the play button next to the test suite or individual tests.

### Unit Tests

- **ViewModel Tests**: Tests for `MWeatherViewModel` to ensure it correctly fetches and processes data.
- **Repository Tests**: Tests for `WeatherUseCase` to ensure it correctly interacts with the data source.
