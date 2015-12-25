//
//  SeasonTests.swift
//  SportsApp2
//
//  Created by Matthew Liu on 11/4/15.
//
//

import XCTest
import UIKit

class SeasonTests: XCTestCase {
	
// MARK: Season Tests
	// Tests Season Object Constructor
	func testSeasonInitialization() {
		// Success Case
		let testSeason = Season(url: "http://espn.go.com/college-football/team/schedule?id=356&year=2015")
		XCTAssertNotNil(testSeason)
		
		// Failure Case
		let failedSeason = Season(url: "")
		XCTAssertNil(failedSeason)
	}
	
	// Tests Extract Games
	// Tests the First Entry in the List
	// Tests the Last Entry in the List
	func testSeasonExtractGames() {
		// Load Game List into Memory
		let testSeason = Season(url: "http://espn.go.com/college-football/team/schedule?id=356&year=2015")
		
		// First Game of the Season
		XCTAssertEqual(testSeason!.Games[0].Date, "Sept 5")
		XCTAssertEqual(testSeason!.Games[0].Opponent, "Kent State")
		XCTAssertEqual(testSeason!.Games[0].Result, "52-3")
		XCTAssertEqual(testSeason!.Games[0].illiniWin, true)
		
		// Last Game of the Season
		let arrayLength = (testSeason!.Games.count) - 1
		XCTAssertEqual(testSeason!.Games[arrayLength].Date, "Nov 28")
		XCTAssertEqual(testSeason!.Games[arrayLength].Opponent, "#18 Northwestern*")
		XCTAssertEqual(testSeason!.Games[arrayLength].Result, "TBD")
		XCTAssertEqual(testSeason!.Games[arrayLength].illiniWin, false)
	}
	
	

}