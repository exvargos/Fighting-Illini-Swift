//
//  Season.swift
//  SportsApp2
//
//  Created by Matthew Liu on 11/4/15.
//
//	Kanna HTML Parsing found: https://github.com/tid-kijyun/Kanna

import UIKit
import Kanna

class Season {
	
// MARK: Properties
	var Games: [GameInfo]
	
	// Constructor, loads URL into system
	init?(url: String) {
		Games = [GameInfo]()
		// Return a nil object if url is empty or fails
		do {
			let seasonHTML = try String(contentsOfURL: NSURL(string: url)!, encoding: NSISOLatin1StringEncoding)
			extractGames(seasonHTML)
		} catch {
			return nil
		}
	}
	
	// Extract game list from Schedule
	// Saves information into Array of GameInfo Objects
	func extractGames(seasonHTML: String) {
		if let doc = Kanna.HTML(html: seasonHTML, encoding: NSUTF8StringEncoding) {

			// Search for nodes by CSS
			// Get individual Game Information
			if let seasonRows = doc.at_xpath("//div[@id='showschedule']") {
				for gameRow in seasonRows.css("tr") {
					
					var gameDate = "", gameOpponent = "", gameOpponentLogo = "", gameResult = "", gameID = "", gameTickets = ""
					var illiniWin = false
					
					// Match Date
					if let matchDate = gameRow.at_css("td") {
						if matchDate.text?.characters.count > 5 {
							gameDate = matchDate.text!.substringFromIndex(matchDate.text!.startIndex.advancedBy(5))
						}
					}
					
					// Team Logo URL
					if let teamLogo = gameRow.at_css("img") {
						gameOpponentLogo = teamLogo["src"]!
					}
					
					// Team Name
					if let teamName = gameRow.at_css("li.team-name a") {
						gameOpponent = teamName.text!
					}
					
					// Score and GameID
					if let score = gameRow.at_css("li.score a") {
						gameResult = score.text!
						
						// Game ID Number
						let needle: Character = "="
						if let idx = score["href"]?.characters.indexOf(needle) {
							let pos = score["href"]?.startIndex.distanceTo(idx)
							gameID = (score["href"]?.substringFromIndex((score["href"]?.startIndex.advancedBy(pos! + 1))!))!
						}
					}
					
					// Win-Loss
					if let _ = gameRow.at_css("span.greenfont") {
						illiniWin = true
					}
					if let _ = gameRow.at_css("span.redfont") {
						illiniWin = false
					}
					
					// Get future Game Information
					for column in gameRow.css("td") {

						// Game Time
						if ((column.text?.rangeOfString("ET")) != nil) {
							gameResult = (column.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()))!
						}
						
						// Ticket Link
						if let ticketURL = column.at_css("a") {
							if ((ticketURL["href"]?.rangeOfString("stubhub")) != nil) {
								gameTickets = ticketURL["href"]!
							}
						}
					}
					
					// Add proper games to overarching data structure
					if gameOpponent != "" {
						// Create Game Object based off information
						let newGame = GameInfo(Date: gameDate, Opponent: gameOpponent, OpponentLogo: gameOpponentLogo, Result: gameResult, illiniWin: illiniWin, gameID: gameID, ticketLink: gameTickets)
						
						if newGame.gameID != "" {
							newGame.extractGameLocation()
						}
						
						// Append to Array of Games
						Games.append(newGame)
					}
				}
			}
		}
	}
	
}
	
