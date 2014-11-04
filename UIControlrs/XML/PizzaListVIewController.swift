//
//  PizzaListVIewController.swift
//  UIControlrs
//
//  Created by Sivavardhan Reddy on 11/4/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

import Foundation
import UIKit
class PizzaListVIewController:UIViewController,ConnectionProtocol
{
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var itemsListView: UITableView!
    var pizzasListArray:NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Pizza"
        getPizzas()
        
    }
    func getPizzas()
    {
        self.indicatorView.startAnimating()
        let connectionClassObject:UrlConnectionClass = UrlConnectionClass()
        connectionClassObject.getResponseWithMethod("", parameters: "", httpMethod: "")
        connectionClassObject.delegate = self
    }
    //MARK:ConnectionProtocol
    func getConnectionFailed()
    {
        
    }
    func getConnectionScuessed()
    {
        
    }
    func parsingCompletedWithArray(listArray:NSMutableArray)
    {
        self.pizzasListArray = listArray
        self.itemsListView.reloadData()
        self.indicatorView.stopAnimating()
    }
    
    //MARK: UItabelViewDataSource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.pizzasListArray.count > 0
        {
        return self.pizzasListArray.count
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        let pizzaObj: PizzaModel = self.pizzasListArray.objectAtIndex(indexPath.row) as PizzaModel
        cell.textLabel.text = pizzaObj.pizzaName
        cell.detailTextLabel?.text = pizzaObj.pizzaDescription
        return cell
    }

}