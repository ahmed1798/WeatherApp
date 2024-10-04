//
//  WeatherViewModelTests.swift
//  WeatherAppTests
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import XCTest
import Combine
@testable import WeatherApp

final class WeatherViewModelTests: XCTestCase {
    
    var sut: WeatherViewModel!
    var mockUseCase: MockWeatherUseCase!
    var anyCancellable: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockWeatherUseCase()
        sut = WeatherViewModel(useCases: mockUseCase)
        anyCancellable = []
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        mockUseCase = nil
        anyCancellable = nil
    }
    
    // MARK: -  Test Fetch WEATHER With Success Data
    func testFetchWeather_WithSuccessData_ShouldReturnSuccess() {
        
        //: ARRANGE
        let expectation = self.expectation(description: "Fetch Weather With Success Data")
        
        //: ACT
        sut.fetchWeather(cityName: "cairo")
        
        //: ASSERT
        sut.$weatherList.dropFirst()
            .sink { weatherList in
                XCTAssertEqual(weatherList.count, 1)
                XCTAssertEqual(weatherList.first?.main?.temp, 30.42)
                XCTAssertEqual(weatherList.first?.main?.humidity, 35)
                XCTAssertEqual(weatherList.first?.wind?.speed, 3.23)
                expectation.fulfill()
            }
            .store(in: &anyCancellable)
        
        self.wait(for: [expectation], timeout: 5.0)
    }
    
    //MARK: - Test Fetch WEATHER With Invalid API Key
    func testFetchWeather_WithInvalidAPIKey_ShouldReturnFailure() {
        
        //: ARRANGE
        let expectation = self.expectation(description: "Fetch Weather With Invalid API Key Error")
        mockUseCase.shouldReturnError = true
        mockUseCase.errorType = .invalidAPIKey
        
        //: ACT
        sut.fetchWeather(cityName: "cairo")
        
        //: ASSERT
        sut.$errorMessage
            .dropFirst().sink { errorMessage in
                XCTAssertEqual(errorMessage, "Invalid ApiKey")
                expectation.fulfill()
            }
            .store(in: &anyCancellable)
        
        self.wait(for: [expectation], timeout: 5.0)
    }
    
    // MARK: - Test Fetch WEATHER When Invalid URL
    func testFetchWeather_WithInvalidURL_ShouldReturnFailure() {
        
        //: ARRANGE
        let expectation = XCTestExpectation(description: "Fetch Weather With Invalid URL Error")
        mockUseCase.shouldReturnError = true
        mockUseCase.errorType = .invalidURL
        
        //: ACT
        sut.fetchWeather(cityName: "cairo")
        
        //: ASSERT
        sut.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, "Invalid URL")
                expectation.fulfill()
            }
            .store(in: &anyCancellable)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    //MARK: - Test Fetch WEATHER With Other Error
    func testFetchAWeather_WithOtherError_ShouldReturnFailure() {
        
        //: ARRANGE
        let expectation = XCTestExpectation(description: "Fetch Weather With Other Error")
        mockUseCase.shouldReturnError = true
        mockUseCase.errorType = .other(NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Internal Server Error"]))
        
        //: ACT
        sut.fetchWeather(cityName: "cairo")
        
        //: ASSERT
        sut.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, "Internal Server Error")
                expectation.fulfill()
            }
            .store(in: &anyCancellable)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
}
