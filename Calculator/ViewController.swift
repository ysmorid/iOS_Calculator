//
//  ViewController.swift
//  Calculator
//
//  Created by Ylia Moridzadeh on 3/30/17.
//  Copyright © 2017 Ylia Moridzadeh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsCurrentlyTyping = false
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsCurrentlyTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }
        else {
            display.text = digit
            userIsCurrentlyTyping = true;
        }
        
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        userIsCurrentlyTyping = false
        
        if let mathSymbol = sender.currentTitle {
            switch mathSymbol {
            case "π":
                displayValue = Double.pi
            case "√":
                displayValue = sqrt(displayValue)
            default:
                break
            }
        }
    }
}

