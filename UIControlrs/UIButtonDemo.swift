//
//  UIButtonDemo.swift
//  UIControlrs
//
//  Created by Sivavardhan Reddy on 10/28/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

import Foundation
import UIKit

class UIButtonDemo : UIViewController
{
    @IBAction func buttonClicked(sender: AnyObject) {
        let selectedButton:UIButton = sender as UIButton
        print("\nthe Tag is:\(selectedButton.tag)")
        
    }
    @IBAction func changeBackgroundButtonClicked(sender: AnyObject) {
        getColorAndChageBackground()
    }
    func getColorAndChageBackground()
    {
        var redRandomValue = 1+arc4random_uniform(UInt32(255-0+1))
        var greenRandomValue = 1+arc4random_uniform(UInt32(255-0+1))
        var blueRandomValue = 1+arc4random_uniform(UInt32(255-0+1))
        
        var redFloatValue : Float = Float(redRandomValue) / 255.0
        var greenFloatValue : Float = Float(greenRandomValue) / 255.0
        var blueFloatValue : Float = Float(blueRandomValue) / 255.0
        
        
        self.view.backgroundColor = UIColor(red: CGFloat(redFloatValue), green: CGFloat(greenFloatValue), blue: CGFloat(blueFloatValue), alpha: 1.0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Button Demo"
        getColorAndChageBackground()
    }
}

