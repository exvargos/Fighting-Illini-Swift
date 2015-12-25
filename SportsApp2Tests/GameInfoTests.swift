//
//  SportsApp2Tests.swift
//  SportsApp2Tests
//
//  Created by Matthew Liu on 11/4/15.
//
//

import XCTest
import UIKit

class GameInfoTests: XCTestCase {
	
// MARK: GameInfo Tests
	// Tests GameInfo Object Constructor
	func testGameInfoInitialization() {
		// Initialization Variables
		let gameDate = "Sat, Sept 22"
		let gameOpponent = "Michigan State"
		let gameResult = "1000000-0"
		let illiniWin = true
		let ticketLink = "http://ticket.link"
		let testGame = GameInfo(Date: gameDate, Opponent: gameOpponent, OpponentLogo: "", Result: gameResult, illiniWin: illiniWin, gameID: "", ticketLink: ticketLink)
		
		// Asserts
		XCTAssertEqual(gameDate, testGame.Date)
		XCTAssertEqual(gameOpponent, testGame.Opponent)
		XCTAssertEqual(gameResult, testGame.Result)
		XCTAssertEqual(illiniWin, testGame.illiniWin)
		XCTAssertEqual(ticketLink, testGame.ticketLink)
		
	}
	
}