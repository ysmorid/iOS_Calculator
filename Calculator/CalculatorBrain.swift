//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Ylia Moridzadeh on 3/31/17.
//  Copyright © 2017 Ylia Moridzadeh. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    mutating func performOperation(_ symbol: String) {
        switch symbol {
        case "π":
            accumulator = Double.pi
        case "√":
            if let operand = accumulator{
                accumulator = sqrt(operand)
            }
        default:
            break
        }
        
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
}
