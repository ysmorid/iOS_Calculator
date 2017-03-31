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
    private enum Operation {
        case constant (Double)
        case unaryOperation((Double) -> Double)
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "sin": Operation.unaryOperation(sin),
        "cos": Operation.unaryOperation(cos),
        "tan": Operation.unaryOperation(tan),
        "±": Operation.unaryOperation(changeSign),
        
        ]
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation (let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            }
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    
}

func changeSign(operand: Double) -> Double {
    return -operand
}
