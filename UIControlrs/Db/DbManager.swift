//
//  DbManager.swift
//  UIControlrs
//
//  Created by Sivavardhan Reddy on 10/29/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

import Foundation
class DbManager: NSObject
{
    func getDocumentPath() -> NSString
    {
        var documentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        documentPath = documentPath.stringByAppendingPathComponent("Student.sqlite")
         return documentPath
    }
    func getSqliteDocumentPath() -> NSString
    {
        var fromPath: NSString = NSBundle.mainBundle().pathForResource("Student", ofType: "sqlite")!
        return fromPath
    }
    func copyFilesFrombundelToDocumentary()
    {
        let documentPath = getDocumentPath()
        
        var fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(documentPath)
        {
            let dbFilePath = getSqliteDocumentPath()
            fileManager.copyItemAtPath(dbFilePath, toPath: documentPath, error: nil)
            
        }
        
    }
    func selectStudentsWithQuery(query:NSString) -> NSMutableArray
    {
        var studentsArray :NSMutableArray = []
        
        let documentPath = getDocumentPath()
        let utf8DbPath = documentPath.cStringUsingEncoding(NSUTF8StringEncoding)
        var database:COpaquePointer = nil
        let error = sqlite3_open(utf8DbPath, &database)
        if sqlite3_open(utf8DbPath, &database) == SQLITE_OK
        {
            println("opend")
            var selectQuery = "SELECT * FROM Studebt"
            var cSql = query.cStringUsingEncoding(NSUTF8StringEncoding)
            var stmt:COpaquePointer = nil
            if sqlite3_prepare(database, cSql, -1, &stmt, nil) == SQLITE_OK
            {
                while sqlite3_step(stmt) == SQLITE_ROW
                {
                    var studentObj:Student = Student()
                    let name = sqlite3_column_text(stmt, 0)
                    let rollNumber = sqlite3_column_int(stmt, 1)
                    let studentClass = sqlite3_column_text(stmt, 2)
                    let age = sqlite3_column_int(stmt, 3)
                    
                    studentObj.studentName = String.fromCString(UnsafePointer<CChar>(name))!
                    studentObj.studentRoolNumber = String(rollNumber)
                    studentObj.studentClass = String.fromCString(UnsafePointer<CChar>(studentClass))!
                    studentObj.studentAge = Int(age)
                    studentsArray.addObject(studentObj)
                    
                }
                
            }
            sqlite3_finalize(stmt)
            
        }
        sqlite3_close(database)
        return studentsArray
    }
    func executeSqlStatment(query:NSString) -> Bool
    {
        var isExcuteScuess:Bool = false
        let documentPath = getDocumentPath()
        var utf8DocPath = documentPath.cStringUsingEncoding(NSUTF8StringEncoding)
        var dataBase:COpaquePointer = nil
        if sqlite3_open(utf8DocPath, &dataBase) == SQLITE_OK
        {
            let queryUTF8 = query.cStringUsingEncoding(NSUTF8StringEncoding)
            var statment:COpaquePointer = nil
            if sqlite3_prepare_v2(dataBase, queryUTF8, -1, &statment, nil) == SQLITE_OK
            {
                if sqlite3_step(statment) == SQLITE_DONE
                {
                    isExcuteScuess = true
                }
                else
                {
                    isExcuteScuess = false
                }
            }
            else
            {
                println("There is a pbm During Prepare a statment")

            }
            sqlite3_finalize(statment)
        }
        else
        {
            println("There is a pbm During open Database")
        }
        sqlite3_close(dataBase)

        return isExcuteScuess
    }
    func getHeighstRollNumber() -> Int
    {
        var rollNumber=0
        let documentPath = getDocumentPath()
        var utf8DocPath = documentPath.cStringUsingEncoding(NSUTF8StringEncoding)
        var dataBase:COpaquePointer = nil
        if sqlite3_open(utf8DocPath, &dataBase) == SQLITE_OK
        {
            let query = "select RollNo From Studebt ORDER BY RollNo DESC LIMIT 1"
            let queryUTF8 = query.cStringUsingEncoding(NSUTF8StringEncoding)
            var statment:COpaquePointer = nil
            if sqlite3_prepare_v2(dataBase, queryUTF8!, -1, &statment, nil) == SQLITE_OK
            {
                if sqlite3_step(statment) == SQLITE_ROW
                {
                    rollNumber = Int(sqlite3_column_int(statment, 0))
                }
            }
            else
            {
                println("There is a pbm During Prepare a statment")
                
            }
            sqlite3_finalize(statment)
        }
        else
        {
            println("There is a pbm During open Database")
        }
        sqlite3_close(dataBase)

        return rollNumber
    }
}