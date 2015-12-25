//
//  MatchDetailViewController.swift
//  SportsApp2
//
//  Created by Matthew Liu on 11/14/15.
//
//

import UIKit
import SafariServices

class MatchDetailViewController: UIViewController {

	// Game Object Passed from Table View
	var game: GameInfo!
	@IBOutlet weak var stadiumImageView: UIImageView!
	@IBOutlet weak var stadiumName: UILabel!
	@IBOutlet weak var gameLink: UIBarButtonItem!
	
	@IBOutlet weak var boxscore: UIWebView!
	@IBOutlet weak var OpponentLogo: UIImageView!
	@IBOutlet weak var OpponentName: UILabel!
	
	@IBOutlet weak var IlliniName: UILabel!
	
	// Settings for this view to set on load
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		navigationItem.title = ( game.illiniWin ? "Victory" : "Loss")

		// Set Stadium Name and Image
		if game.gameID != "" {
			if let stadiumURL = NSURL(string: game.stadiumImgURL) {
				if let data = NSData(contentsOfURL: stadiumURL) {
					self.stadiumImageView.image = UIImage(data: data)
					self.stadiumName.text = game.stadiumLocation
				}
			}
			
//			boxscore.loadHTMLString(game.boxscore, baseURL: nil)
			
		} else { // Future Game
			
			// Change Button Title
			gameLink.title = "Tickets"
			self.stadiumImageView.image = UIImage(named: "ILL-INI")
			self.stadiumName.text = "GO ILLINI! LETS BEAT \(game.Opponent.uppercaseString)"
			
			navigationItem.title = game.Date + "- WE WILL WIN"

		}
		
		// Set Team Information
		OpponentName.text = game.Opponent + " on \(game.Date) at"
		if let logoURL = NSURL(string: game.OpponentLogo) {
			if let data = NSData(contentsOfURL: logoURL) {
				OpponentLogo.image = UIImage(data: data)
			}
		}
		
		// Make Bar Text White
		navigationController?.navigationBar.tintColor = UIColor.whiteColor()
		
		self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImageRight")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	// Opens WebPage in iOS9 SafariView, much faster and better functionality than the deprecated UIWebView
	@IBAction func OpenURL(sender: AnyObject) {
		var svc = SFSafariViewController(URL: NSURL(string: game.buildSummaryURL())!)
		
		// Future Game, link to tickets
		if ((game.Result.rangeOfString("ET")) != nil) {
			svc = SFSafariViewController(URL: NSURL(string: game.ticketLink)!)
		}
		
		self.presentViewController(svc, animated: true, completion: nil)
	}


}
