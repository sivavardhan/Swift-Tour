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
//                    studentObj.studentName = NSString(UTF8String: name) as String
                    
                    studentsArray.addObject(studentObj)
                    
                }
                
            }
            sqlite3_finalize(stmt)
            
        }
        sqlite3_close(database)
        return studentsArray
    }
    
}