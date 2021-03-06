//
//  StudentsListViewController.swift
//  UIControlrs
//
//  Created by Sivavardhan Reddy on 10/29/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

import Foundation
import UIKit
class StudentsListViewController:UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var StudentListView: UITableView!
    @IBOutlet weak var asdas: UITableView!
    var studentsDetails:NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
//        addStudentDetailsStatically()
        self.title = "Students"
        var navigationRightBarButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("addButtonClicked"))
        self.navigationItem.rightBarButtonItem = navigationRightBarButton
        let documentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        print(documentPath)
    }
     override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        var dbClass:DbManager = DbManager()
        dbClass.copyFilesFrombundelToDocumentary()
        self.studentsDetails = dbClass.selectStudentsWithQuery("SELECT * FROM Studebt")
        self.StudentListView.reloadData()
    }
    func addButtonClicked()
    {
        self.performSegueWithIdentifier("addstudent", sender: self)
    }
    func addStudentDetailsStatically()
    {
        for var i = 0; i<10; i++
        {
            var studentObj:Student = Student()
            studentObj.studentName = "SName \(i)"
            studentObj.studentRoolNumber = "SNO\(i)"
            studentObj.studentClass = "Class \(i)"
            studentObj.studentAge = 10+i
            self.studentsDetails.addObject(studentObj)
        }
    }
    //MARK: UItabelViewDataSource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentsDetails.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:StudentCell = tableView.dequeueReusableCellWithIdentifier("studentCell") as StudentCell
        let studentObj: Student = studentsDetails.objectAtIndex(indexPath.row) as Student
        
        cell.nameLabel.text = studentObj.studentName
        cell.classLabel.text = studentObj.studentClass
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier != "addstudent"
        {
            let indexPath:NSIndexPath = self.StudentListView.indexPathForSelectedRow()!
            self.StudentListView.deselectRowAtIndexPath(indexPath, animated: true)
            var destinationViewController:StudentAddOrDetailViewController = segue.destinationViewController as StudentAddOrDetailViewController
            destinationViewController.studentObj=self.studentsDetails.objectAtIndex(indexPath.row) as Student
        }
    }
}