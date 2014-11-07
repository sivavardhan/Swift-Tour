//
//  MeetingListViewController.swift
//  UIControlrs
//
//  Created by Sivavardhan Reddy on 11/6/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

import Foundation
import UIKit

class MeetingListViewController:UIViewController {
    var responseData:NSMutableData = NSMutableData()

    override func viewDidLoad() {
        super.viewDidLoad()
        getJsonResponse()
    }
    
    func getJsonResponse()
    {
        let url:NSURL = NSURL(string: "https://api.meetup.com/2/groups?lat=51.509980&lon=-0.133700&page=20&key=1f5718c16a7fb3a5452f45193232")!
        let urlRequest:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        var nsurlConnection = NSURLConnection(request: urlRequest, delegate: self)
        nsurlConnection?.start()
//        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: nil) { (response, data, error) -> Void in
//            let responseDict:NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
//            println(responseDict)
//        }
    }
    //MARK: UItabelViewDataSource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        return cell
    }
    //MARK: NSURLCONNECTION DataSourceMethod
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse)
    {
        println("recive Response")
    }
    func connection(connection: NSURLConnection, didReceiveData data: NSData)
    {
        responseData.appendData(data)
    }
    func connectionDidFinishLoading(connection: NSURLConnection)
    {
        let responseString = NSString(data: responseData, encoding: NSUTF8StringEncoding)
        println("the Data is: \(responseString)")
        let responseDict:NSDictionary = NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
//        println(responseDict)
        var resultsArray:NSArray = responseDict["results"] as NSArray
        for dict in resultsArray
        {
            println("name"+)
            println(dict["description"])
        }

    }


}