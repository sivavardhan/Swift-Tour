//
//  UrlConnectionClass.swift
//  UIControlrs
//
//  Created by Sivavardhan Reddy on 10/31/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

import Foundation
protocol ConnectionProtocol
{
    func getConnectionFailed()
    func getConnectionScuessed()
    func parsingCompletedWithArray(listArray:NSMutableArray)
}
class UrlConnectionClass: NSObject,NSURLConnectionDelegate,NSXMLParserDelegate {
    var delegate:ConnectionProtocol?
    var responseData:NSMutableData = NSMutableData()
    var isParsing = false
    var startTag:String!
    var pizzasArray:NSMutableArray = NSMutableArray()
    var pizzaObjext:PizzaModel!
    func getResponseWithMethod(getmethodName:String,parameters:String,httpMethod:NSString)
    {
        let url:NSURL = NSURL(string: "http://api.androidhive.info/pizza/?format=xml")!
        
        let urlRequest:NSMutableURLRequest = NSMutableURLRequest(URL: url)
//        urlRequest.HTTPMethod = "POST"
//        var parametersData = parameters.dataUsingEncoding(NSUTF8StringEncoding)
//        var contentLength = String(countElements(parameters))
//        urlRequest.addValue(contentLength, forHTTPHeaderField: "Content-Length")
//        urlRequest.addValue("text/xml; charset=utf-8", forHTTPHeaderField:"Content-Type")
//        urlRequest.addValue("application/xml", forHTTPHeaderField:"Accept")
//        urlRequest.addValue("http://www.webserviceX.NET/GetCitiesByCountry", forHTTPHeaderField: "SOAPAction")
//        urlRequest.HTTPBody = parametersData

        var urlConnection:NSURLConnection = NSURLConnection(request: urlRequest, delegate: self, startImmediately: true)!
    }
    //MARK: NSURLCONNECTION Delegate
     func connection(connection: NSURLConnection, didFailWithError error: NSError)
    {
        println(error.description)
        println("Connection Failure")
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
        var parser:NSXMLParser = NSXMLParser(data: responseData)
        parser.delegate = self
        parser.parse()
    }
    
    
    //MARK: NSXMLPARSER Delegate
   func parserDidStartDocument(parser: NSXMLParser!)
   {
    }
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!)
    {
//        println(elementName)
        
        self.startTag = elementName
        if elementName == "item"
        {
            pizzaObjext = PizzaModel()
        }
    }
    func parser(parser: NSXMLParser!, foundCharacters string: String!)
    {
        if self.startTag == "id"
        {
//            println("id: \(string)")
            self.pizzaObjext.pizzaId = string
        }
        else if self.startTag == "name"
        {
//            println("Name \(string)")
            self.pizzaObjext.pizzaName = string
        }
        else if self.startTag == "cost"
        {
//            println("Cost is: \(string)")
            self.pizzaObjext.pizzaCost = string
        }
        else if self.startTag == "description"
        {
//            println("description is: \(string)")
            self.pizzaObjext.pizzaDescription = string
        }

    }
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
//        println(elementName)
        if elementName=="name"
        {
            isParsing = false
        }
        self.startTag = ""
        if elementName == "item"
        {
            self.pizzasArray.addObject(self.pizzaObjext)
            pizzaObjext = nil
        }

    }
    func parserDidEndDocument(parser: NSXMLParser!)
    {
        for  pizzaObject1 in self.pizzasArray
        {
            println(pizzaObject1.pizzaName)
        }
        self.delegate?.parsingCompletedWithArray(self.pizzasArray)
    }


}