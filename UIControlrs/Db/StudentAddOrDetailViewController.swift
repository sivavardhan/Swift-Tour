//
//  StudentAddOrDetailViewController.swift
//  UIControlrs
//
//  Created by Sivavardhan Reddy on 10/29/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

import Foundation
import UIKit
class StudentAddOrDetailViewController: UIViewController
{
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var classTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    var studentObj:Student!
    override func viewDidLoad() {
        super.viewDidLoad()
        if studentObj != nil
        {
            self.nameTextField.text = studentObj.studentName
            self.classTextField.text = studentObj.studentClass
            self.ageTextField.text = String(studentObj.studentAge)
            self.navigationItem.title = studentObj.studentName
            let deleteBarButton = UIBarButtonItem(title: "Delete", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("deleteButtonClicked"))
            self.navigationItem.rightBarButtonItem = deleteBarButton
        }
    }
    func deleteButtonClicked()
    {
        var deleteStament = "DELETE from Studebt where RollNo = \(studentObj.studentRoolNumber)"
        performDBOperation(deleteStament)

    }
    @IBAction func saveButtonClicked(sender: AnyObject)
    {
        if studentObj != nil
        {
          println("Update Tabel")
            var updateStament = "UPDATE Studebt SET Name = '\(nameTextField.text)',Class ='\(classTextField.text)',Age = \(ageTextField.text) where RollNo =\(studentObj.studentRoolNumber)"
            println(updateStament)
            performDBOperation(updateStament)

        }
        else
        {
          println("Insert into Tabel")
            if (countElements(nameTextField.text) > 0) && (countElements(classTextField.text) > 0) && (countElements(ageTextField.text) > 0)
            {
                let dbManager:DbManager = DbManager()
                let roolNumber = dbManager.getHeighstRollNumber()+1
                var insertStament = "insert into Studebt VALUES ('\(nameTextField.text)'"+",\(roolNumber)"+",'\(classTextField.text)'"+",\(ageTextField.text)"+")"
                performDBOperation(insertStament)
            }
        }
    }
    @IBAction func cancelButtonClicked(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    func performDBOperation(quey:NSString)
    {
        let dbManager:DbManager = DbManager()
        
        if dbManager.executeSqlStatment(quey) == true
        {
            self.navigationController?.popViewControllerAnimated(true)
        }

    }
    
}