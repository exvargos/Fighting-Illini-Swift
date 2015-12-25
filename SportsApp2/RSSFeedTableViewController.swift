//
//  RSSFeedTableViewController.swift
//  SportsApp2
//
//  Created by Matthew Liu on 12/1/15.
//
//

import UIKit
import SafariServices

class RSSFeedTableViewController: UITableViewController, NSXMLParserDelegate {
	
// MARK: Properties
	// XML Parser
	var parser: NSXMLParser = NSXMLParser()
	
	// Array Holding All News Items
	var newsItems: [NewsItem] = []
	
	// Helper Variables for Parsing
	var newsTitle: String = String()
	var newsLink: String = String()
	var newsDate: String = String()
	var eName: String = String()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		// Sets URL To parse and begins parsing
		let rssFeedURL:NSURL = NSURL(string: "http://bigten.cstv.com/sports/m-footbl/headline-rss.xml")!
		parser = NSXMLParser(contentsOfURL: rssFeedURL)!
		parser.delegate = self
		parser.parse()

		// Set Background Wallpaper
		tableView.backgroundView = UIImageView(image: UIImage(named: "backgroundImageMain"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// MARK: - Table View Funcs
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		// Gets Current Cell and sets appropriate title
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
		let newsItem: NewsItem = newsItems[indexPath.row]
		cell.textLabel!.text = newsItem.newsTitle
		
		// Adds Button
		cell.accessoryType = .DetailDisclosureButton
		
		return cell
	}
	
	// Opens Post Link in SafariView when cell is clicked
	override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
		let newsItem = newsItems[indexPath.row]
		let svc = SFSafariViewController(URL: NSURL(string: newsItem.newsLink)!)
		self.presentViewController(svc, animated: true, completion: nil)
	}
	
// MARK: Drawer
	@IBAction func OpenLeftNavDrawer(sender: UIBarButtonItem) {
		let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		appDelegate.centerContainer!.toggleDrawerSide(.Left, animated: true, completion: nil)

	}
	
// MARK: NSXMLParserDelegate Methods
	// Initializes variables for parsing
	func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
		eName = elementName
		if elementName == "item" {
			newsTitle = String()
			newsLink = String()
			newsDate = String()
		}
	}
	
	// Interprets the different XML Items and stores them separately
	func parser(parser: NSXMLParser, foundCharacters string: String) {
		let data = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
		if (!data.isEmpty) {
			if eName == "title" {
				newsTitle += data
			} else if eName == "link" {
				newsLink += data
			} else if eName == "pubDate" {
				newsDate += data
			}
		}
	}
	
	// Append Item to master array
	func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
		if elementName == "item" {
			let newsItem: NewsItem = NewsItem()
			newsItem.newsTitle = newsTitle
			newsItem.newsLink = newsLink
			newsItem.newsDate = newsDate
			newsItems.append(newsItem)
		}
	}
}
