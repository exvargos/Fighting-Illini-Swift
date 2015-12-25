//
//  MatchTableViewController.swift
//  SportsApp2
//
//  Created by Matthew Liu on 11/4/15.
//
//

import UIKit
import DrawerController

class MatchTableViewController: UITableViewController {

// MARK: Properties
	var games: [GameInfo] = []
	
	// Refresh the list of games
	func refresh(sender:AnyObject)
	{
		// Reloads data from URL
		let seasonSchedule = Season(url: "http://espn.go.com/college-football/team/schedule?id=356&year=2015")
		games = (seasonSchedule?.Games)!
		
		self.tableView.reloadData()
		self.refreshControl?.endRefreshing()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Initialize Backend, Load Season Schedule
		let seasonSchedule = Season(url: "http://espn.go.com/college-football/team/schedule?id=356&year=2015")
		games = (seasonSchedule?.Games)!
		
		// Enable Refreshing
		self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)

		tableView.backgroundView = UIImageView(image: UIImage(named: "backgroundImageMain"))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
	}

// MARK: - Table view data source

	// Enable Display
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

	// Returns Number of Rows to Populate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
	
	// Intialize cells for all games
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cellIdentifier = "MatchTableViewCell"
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MatchTableViewCell
		
		let game = games[indexPath.row]
		
		if let logoURL = NSURL(string: game.OpponentLogo) {
			if let data = NSData(contentsOfURL: logoURL) {
				cell.teamLogo.image = UIImage(data: data)
			}
		}
		cell.teamNameLabel.text = game.Date + ": " + game.Opponent
		cell.statusLabel.text = game.Result
		if ((game.Result.rangeOfString("ET")) == nil) {
			cell.statusLabel.text = (game.illiniWin ? "Win" : "Loss") + ": " + game.Result
		}

        return cell
    }


// MARK: - Navigation

    // Passes URL onto WebPageView
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		let svc = segue.destinationViewController as! MatchDetailViewController

		// Set back button name
		let backItem = UIBarButtonItem()
		backItem.title = "Season"
		navigationItem.backBarButtonItem = backItem
		
		// Get Current cell and pass Game information along
		let indexPath = self.tableView.indexPathForSelectedRow!
		svc.game = games[indexPath.row]
    }

	// Links Left Nav Button to Openning the Navigation Drawer
	@IBAction func OpenLeftNavDrawer(sender: UIBarButtonItem) {
		let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		appDelegate.centerContainer!.toggleDrawerSide(.Left, animated: true, completion: nil)
	}
}
