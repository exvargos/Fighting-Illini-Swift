//
//  GameInfo.swift
//  SportsApp2
//
//  Created by Matthew Liu on 11/4/15.
//
//

import UIKit
import Kanna

class GameInfo {
	
// MARK: Properties
	let Date: String
	let Opponent: String, OpponentLogo: String
	let Result: String
	let illiniWin: Bool
	let gameID: String

	var stadiumImgURL: String
	var stadiumLocation: String
	var ticketLink: String
	var boxscore: String
	
	// Constructor
	init(Date: String, Opponent: String, OpponentLogo: String, Result: String,  illiniWin: Bool, gameID: String, ticketLink: String) {
		self.Date = Date
		self.Opponent = Opponent
		self.OpponentLogo = OpponentLogo
		self.Result = Result
		self.illiniWin = illiniWin
		self.gameID = gameID
		self.stadiumImgURL = ""
		self.stadiumLocation = ""
		self.ticketLink = ticketLink
		self.boxscore = ""
	}
	
	// Extracts Game Information
	func extractGameLocation() {
		do {
			let gameHTML = try String(contentsOfURL: NSURL(string: self.buildSummaryURL())!, encoding: NSISOLatin1StringEncoding)
			if let doc = Kanna.HTML(html: gameHTML, encoding: NSUTF8StringEncoding) {
				for gameSummary in doc.xpath("//article[@class='sub-module game-information']/div[@class='content']/div[@class='game-field']/figure") {
					if let stadiumImgURL = gameSummary.at_css("img") {
						self.stadiumImgURL = stadiumImgURL["src"]!
					}
					if let stadiumLocation = gameSummary.at_css("div.caption-wrapper") {
						self.stadiumLocation = stadiumLocation.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
					}
				}
				
				// Box Score
				if let gameBoxScore = doc.at_css("section.post#pane-main div#gamepackage-matchup-wrap table#linescore") {
					self.boxscore = "<table>\(gameBoxScore.innerHTML!)</table>"
//					print(self.boxscore)
					
				}

			}
		} catch {
		}
	}
	
	// Returns the game Summary URL built from gameID
	func buildSummaryURL() -> String {
		return "http://espn.go.com/ncf/game?id=" + self.gameID
	}
	
}
