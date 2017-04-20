import UIKit

class ViewController: UIViewController {
    
    var savedProgram: CalculatorBrain.PropertyList?
    var userIsCurrentlyTyping = false
    private var brain: CalculatorBrain = CalculatorBrain()
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var calculatorDescription: UILabel!
    
    @IBAction func saveDigit() {
        brain.variableValues["M"] = displayValue
        brain.program = brain.program
        displayValue = brain.result!
    }
    
    @IBAction func displaySavedDigit() {
        brain.setOperand("M")
        displayValue = brain.result!
        
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsCurrentlyTyping {
            let textCurrentlyInDisplay = display.text!
            if (textCurrentlyInDisplay.contains(".") && digit == ".") {
                display.text = textCurrentlyInDisplay
            }
            else {
                display.text = textCurrentlyInDisplay + digit
            }
        }
        else {
            display.text = digit
            userIsCurrentlyTyping = true;
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsCurrentlyTyping {
            brain.setOperand(displayValue)
            userIsCurrentlyTyping = false
        }
        
        if let mathSymbol = sender.currentTitle {
            brain.performOperation(mathSymbol)
            calculatorDescription.text = brain.displayDescription(mathSymbol)
        }
        
        if let result = brain.result {
            displayValue = result
        }
    }
    
    @IBAction func undoLast() {
        if userIsCurrentlyTyping && !display.text!.isEmpty {
            display.text! = display.text!.substring(to: display.text!.index(before: display.text!.endIndex))
            if display.text!.isEmpty {
                display.text! = " "
                userIsCurrentlyTyping = false
            }
        }
        else {
            brain.program = brain.program
            calculatorDescription.text! = brain.undo()
            
        }
    }
    
}
