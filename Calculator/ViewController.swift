import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var calculatorDescription: UILabel!
    
    @IBAction func save() {
        savedProgram = brain.program
    }
    @IBAction func restore() {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result!
        }
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
            calculatorDescription.text = brain.displayDescription()
        }
        
        if let result = brain.result {
            displayValue = result
        }
    }
}

