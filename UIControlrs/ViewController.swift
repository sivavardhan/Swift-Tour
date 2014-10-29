//
//  ViewController.swift
//  UIControlrs
//
//  Created by Sivavardhan Reddy on 10/10/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var uiElementsListTabel: UITableView!
    var uiElementsList:NSArray = ["Label","Button","Text Field","Text View","Tabel View","Segment Controller","Slider","Scroll View","Activity Indicator","Image View","Collection View","Date Picker","Picker View","MapKIt","JSON","XML","Local DB","Application Form Sampel"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - UITabelViewDataSourceMethods

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return uiElementsList.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell :UITableViewCell = self.uiElementsListTabel.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        cell.textLabel.text = uiElementsList[indexPath.row] as? String

        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    //MARK: - UITabelViewDelegateMethods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        println(indexPath.row)
        switch(indexPath.row)
        {
        case 0:
            self.performSegueWithIdentifier("label", sender: self)
        case 1:
            self.performSegueWithIdentifier("button", sender: self)
        case 16:
            self.performSegueWithIdentifier("database", sender: self)
            println("Local Db Clicked")
        default:
            print("Default")
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(segue.identifier);
    }
}

