import UIKit

class ViewController: UIViewController {
    
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
}
