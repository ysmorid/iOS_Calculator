import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    private var pendingBinaryOperation: PendingBinaryOperation?
    private var description = [String]()
    var isPartialResult: Bool = true
    private var internalProgram = [AnyObject]()
    var variableValues: Dictionary <String, Double> = [:]
    
    var result: Double? {
        get {
            return accumulator
        }
        set {
            if newValue != nil{
                accumulator = newValue
            }
            else {
                accumulator = 0.0
            }
        }
    }
    
    typealias PropertyList = AnyObject
    var program: PropertyList {
        get {
            return internalProgram as CalculatorBrain.PropertyList
        }
        set {
            accumulator = 0.0
            internalProgram.removeAll()
            if let arrayOfOperations = newValue as? [AnyObject] {
                for operation in arrayOfOperations {
                    if let variableName = operation as? String {
                        if variableValues[variableName] != nil {
                            setOperand(variableName)
                        }
                    }
                    else if let operand = operation as? Double {
                        setOperand(operand)
                    }
                    else if let symbol = operation as? String {
                        performOperation(symbol)
                    }
                }
            }
        }
    }
    
    private enum Operation {
        case constant (Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
        case clear
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "sin": Operation.unaryOperation(sin),
        "cos": Operation.unaryOperation(cos),
        "tan": Operation.unaryOperation(tan),
        "±": Operation.unaryOperation({-$0}),
        "x²": Operation.unaryOperation({$0 * $0}),
        "+": Operation.binaryOperation({$0 + $1}),
        "-": Operation.binaryOperation({$0 - $1}),
        "x": Operation.binaryOperation({$0 * $1}),
        "/": Operation.binaryOperation({$0 / $1}),
        "=": Operation.equals,
        "C": Operation.clear
    ]
    
    mutating func performOperation(_ mathematicalOperation: String) {
        internalProgram.append(mathematicalOperation as AnyObject)
        if mathematicalOperation != "=" && mathematicalOperation != "√" {
            description.append(mathematicalOperation)
        }
        
        if let calculatorOperationButton = operations[mathematicalOperation] {
            switch calculatorOperationButton {
            case .constant(let value):
                accumulator = value
            case .unaryOperation (let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                isPartialResult = true
                performPendingBinaryOperation()
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
                isPartialResult = false
            case .clear:
                clear()
            }
        }
    }
    
    mutating func setOperand(_ variableName: String){
        result = variableValues[variableName]
        description.append(variableName)
        internalProgram.append(variableName as AnyObject)
    }
    
    mutating func setOperand(_ numericalDigit: Double) {
        accumulator = numericalDigit
        description.append(String(numericalDigit))
        internalProgram.append(numericalDigit as AnyObject)
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
    
    mutating func displayDescription(_ mathematicalOperation:String) -> String {
        if mathematicalOperation == "√" && !isPartialResult {
            description.insert(mathematicalOperation, at: 0)
            description.insert("(", at: 1)
            description.append(")")
            
            return displayResult()
        }
        else if mathematicalOperation == "√" && isPartialResult {
            description.insert(mathematicalOperation, at: description.endIndex - 1)
            description.insert("(", at: (description.endIndex - 1))
            description.append(")")
            
            return displayResult()
        }
        else if description.count == 0 {
            return description.joined() + " "
        }
        else {
            return displayResult()
        }
    }
    
    func displayResult() -> String{
        if isPartialResult {
            return description.joined() + "..."
        }
        else {
            return description.joined() + "="
        }
    }
    
    mutating func displayRevisedDescription() -> String {
        if !description.isEmpty {
            description.removeLast()
            if description.isEmpty {
                return description.joined() + " "
            }
            return description.joined()
        }
        else {
            return description.joined() + " "
        }
    }
    
    mutating func undo() {
        if !internalProgram.isEmpty {
            internalProgram.removeLast()
        }
    }
    
    private mutating func clear() {
        accumulator = 0.0
        description.removeAll()
        internalProgram.removeAll()
        variableValues.removeValue(forKey: "M")
        isPartialResult = true
    }
}
