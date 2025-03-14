//
//  ViewController.swift
//  Calculator
//
//  Created by Ben Gohlke on 5/29/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var positiveNegativeButton: UIButton!
    @IBOutlet weak var percentButton: UIButton!
    
    var brain: CalculatorBrain?
    //var equalTapped: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brain = CalculatorBrain()
        
    }
    
    // MARK: - Action Handlers
    
    @IBAction func operandTapped(_ sender: UIButton) {
        
        if let brain = brain, let digit = sender.currentTitle {
            outputLabel.text = brain.addOperandDigit(digit)
        } else {
            // Alert user
        }
    }
    
    @IBAction func decimal(_ sender: UIButton) {

        if outputLabel.text == "0"
        {
            outputLabel.text = brain?.addOperandDigit("0.")
        }
        else
        {
            if !outputLabel.text!.contains(".") {
                outputLabel.text = brain?.addOperandDigit(".")
            }
        }
    }
    
    @IBAction func operatorTapped(_ sender: UIButton) {
        
        if let brain = brain, let operatorType = sender.currentTitle {
            brain.setOperator(operatorType)
        }
    }
    
    @IBAction func equalTapped(_ sender: UIButton) {
        guard let brain = brain else { return }
        
        if let calculation = brain.calculateIfPossible() {
            outputLabel.text = calculation
        }
        clearTransaction()
    }
    
    @IBAction func clearTapped(_ sender: UIButton) {
        outputLabel.text = "0"
        clearTransaction()
    }
    
    // MARK: - Private
    
    private func clearTransaction() {
        let lastCalculation = outputLabel.text
        brain = CalculatorBrain()
        outputLabel.text = lastCalculation
    }
    
    @IBAction func percentTapped(_ sender: UIButton) {
        
        guard let outputString: String = outputLabel.text else { return }
        guard let output = Double(outputString) else { return }
        
        let answer = output * 100.0
        
        if percentButton.isTouchInside {
            outputLabel.text = String(format: "%g", answer)
        }
    }
    
    @IBAction func positiveNegativeTapped(_ sender: UIButton) {
        
        outputLabel.text = brain?.switchSign()
        
//        if let outputString = outputLabel.text, outputString.contains("-") {
//
//        } else {
//            let outputString = "-" + outputLabel.text ?? "0"
//
//        }
//
//        guard let output = Double(outputString) else { return }
//
//        if output > 0, positiveNegativeButton.isTouchInside {
//            let newOutput = output - (output * 2)
//            outputLabel.text = String(format: "%g", newOutput)
//        } else {
//            let newOutput = output + (output * 2)
//            outputLabel.text = String(format: "%g", newOutput)
//        }
    }
}

