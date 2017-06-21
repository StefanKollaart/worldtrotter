//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Stefan Kollaart on 19-06-17.
//  Copyright © 2017 Stefan Kollaart. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var labels: [UILabel]!
    
    let letters = CharacterSet.letters
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let hour = Calendar.current.component(.hour, from: Date())
        
        print(hour)
        
        if (hour > 17) || (hour < 6) {
            let darkModeBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            let darkModeTextColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
            let darkModePlaceholderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.5)
            
            view.backgroundColor = darkModeBackgroundColor
            for label in labels {
                label.textColor = darkModeTextColor
            }
            textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSForegroundColorAttributeName : darkModePlaceholderColor ])
            textField.textColor = darkModeTextColor
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
        
        updateCelsiusLabel()
    }
    

    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        let existingTextHasDecimalSeperator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeperator = string.range(of: decimalSeparator)
        
        var isAlphabetical = false
        if let newString = UnicodeScalar(string) {
            if letters.contains(newString) {
                isAlphabetical = true
            }
        }
        
        print(isAlphabetical)

        if (existingTextHasDecimalSeperator != nil && replacementTextHasDecimalSeperator != nil) || isAlphabetical {
            return false
        } else {
            return true
        }
    }
}
