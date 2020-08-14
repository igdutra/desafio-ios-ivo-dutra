//
//  CharactersViewModelTests.swift
//  MarvelCharactersTests
//
//  Created by Ivo Dutra on 14/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class CharactersViewModelTests: XCTestCase {

    var sut: CharactersViewModel!
    var characterViewMock: CharactersViewMock!
    var servicesMock: MarvelCharactersServiceMock!
    var navigationMock: CharactersNavigationDelegateMock!

    override func setUp() {
        super.setUp()
        characterViewMock = CharactersViewMock()
        servicesMock = MarvelCharactersServiceMock()
        navigationMock = CharactersNavigationDelegateMock()

        sut = CharactersViewModel(services: servicesMock,
                                  delegate: characterViewMock,
                                  navigation: navigationMock)
    }

    override func tearDown() {
        sut = nil
        characterViewMock = nil
        servicesMock = nil
        navigationMock = nil
        super.tearDown()
    }

    // MARK: - delegateCalled

    func testDelegateCalled() {

        // Create an expectation for the completion to be called
        let expectation = XCTestExpectation(description: "Completion called")

        sut.get20Characters {
            // Delegate's method is called once request is finished
            XCTAssertTrue(self.characterViewMock.called)

            expectation.fulfill()
        }

        // Wait until the expectation is fulfilled, with a timeout of 5 seconds
        wait(for: [expectation], timeout: 20.0)
    }

}
