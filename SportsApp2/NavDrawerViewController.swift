//
//  NavDrawerViewController.swift
//  SportsApp2
//
//  Created by Matthew Liu on 12/2/15.
//
//

import UIKit
import DrawerController

class NavDrawerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	// MARK: Properties
	let menuItems:[String] = ["Season", "News"]
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		// Set Background
		self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImageLeft")!)
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: Table View Function
	
	// Overrides table view function, returns number of menu Items
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return menuItems.count
	}
	
	// Overrides table view function, sets custom cell
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		// Casts Cell as a custom cell
		let navCell = tableView.dequeueReusableCellWithIdentifier("NavDrawerCell", forIndexPath: indexPath) as! NavDrawerTableViewCell
		
		// Sets text as the appropriate label in the string menuItems
		navCell.menuItemLabel.text = menuItems[indexPath.row]
		
		return navCell
	}
	
	// Function for cell selection
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		// Handles Segue and Transitions
		switch(indexPath.row)
		{
			// Case 0: Season
		case 0:
			
			let centerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! MatchTableViewController
			
			let centerNavController = UINavigationController(rootViewController: centerViewController)
			
			let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
			
			appDelegate.centerContainer!.centerViewController = centerNavController
			appDelegate.centerContainer!.toggleDrawerSide(DrawerSide.Left, animated: true, completion: nil)
		
			break
			
			// Case 1: RSS News Feed
		case 1:
			
			let rssViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RSSFeedList") as! RSSFeedTableViewController
			
			let rssNavController = UINavigationController(rootViewController: rssViewController)
			
			let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
			
			appDelegate.centerContainer!.centerViewController = rssNavController
			appDelegate.centerContainer!.toggleDrawerSide(DrawerSide.Left, animated: true, completion: nil)
			
			break
			
		default:
			print("\(menuItems[indexPath.row]) selected")
		}
		
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
