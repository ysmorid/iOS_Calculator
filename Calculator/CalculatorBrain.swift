

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
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private enum Operation {
        case constant (Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "sin": Operation.unaryOperation(sin),
        "cos": Operation.unaryOperation(cos),
        "tan": Operation.unaryOperation(tan),
        "±": Operation.unaryOperation(changeSign),
        "+": Operation.binaryOperation(add),
        "-": Operation.binaryOperation(subtract),
        "x": Operation.binaryOperation(multiply),
        "/": Operation.binaryOperation(divide),
        "=": Operation.equals
    ]
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
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
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    
}

func changeSign(operand: Double) -> Double {
    return -operand
}

func add(num1: Double, num2: Double) -> Double {
    return num1 + num2
}

func subtract(num1: Double, num2: Double) -> Double {
    return num1 - num2
}

func multiply(num1: Double, num2: Double) -> Double {
    return num1 * num2
}

func divide(num1: Double, num2: Double) -> Double {
    return num1 / num2
}
