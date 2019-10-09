//
//  ViewController.swift
//  playWithColorsApp
//
//  Created by admin on 9/20/19.
//  Copyright © 2019 Timur Korolev. All rights reserved.
//

import UIKit

protocol BackgroundColor {
    var mainVCBackgroundColor: UIColor { get }
}

class SettingsViewController: UIViewController, BackgroundColor {

    @IBOutlet var mainView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var delegate: SettingsViewControllerDelegate!
    
    var mainVCBackgroundColor: UIColor {
        mainView.backgroundColor ?? .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate.setBackgroundColor(mainVCBackgroundColor)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addDoneButton()
        configureTextFields()
        hideKeyboard()
    }

    @IBAction func sliderAction() {
        setMainViewColor()
        transferValueFromSliders()
    }
}

extension SettingsViewController: UITextFieldDelegate {
    
    @objc func doneButtonAction() {
           transferValueFromTextFields()
           setMainViewColor()
           view.endEditing(true)
       }
       
       func textFieldDidEndEditing(_ textField: UITextField) {
           transferValueFromTextFields()
           setMainViewColor()
       }
       
       func hideKeyboard() {
           let tap: UITapGestureRecognizer = UITapGestureRecognizer(
               target: view,
               action: #selector(UIView.endEditing))
           tap.cancelsTouchesInView = false
           view.addGestureRecognizer(tap)
       }
       
       func addDoneButton() {
           let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30)))
           let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
           
           toolbar.setItems([flexSpace, doneBtn], animated: false)
           toolbar.sizeToFit()
           
           redTextField.inputAccessoryView = toolbar
           greenTextField.inputAccessoryView = toolbar
           blueTextField.inputAccessoryView = toolbar
       }
}

extension SettingsViewController {
    private func setupView() {
        mainView.layer.cornerRadius = 15
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
        
        transferValueFromSliders()
        setMainViewColor()
    }
    
    private func configureTextFields() {
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
    }
    
    private func setMainViewColor() {
        mainView.backgroundColor = UIColor(displayP3Red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
    }
    
    private func transferValueFromSliders() {
        redLabel.text = String(roundf(redSlider.value * 100) / 100)
        greenLabel.text = String(roundf(greenSlider.value * 100) / 100)
        blueLabel.text = String(roundf(blueSlider.value * 100) / 100)
        
        redTextField.text = String(roundf(redSlider.value * 100) / 100)
        greenTextField.text = String(roundf(greenSlider.value * 100) / 100)
        blueTextField.text = String(roundf(blueSlider.value * 100) / 100)
    }
    
    private func transferValueFromTextFields() {
        guard let redText = redTextField.text, !redText.isEmpty  else { return }
        if let number = Float(redText) {
            redSlider.value = number
            redLabel.text = String(number)
        }
        guard let greenText = greenTextField.text, !greenText.isEmpty  else { return }
        if let number = Float(greenText) {
            greenSlider.value = number
            greenLabel.text = String(number)
        }
        guard let blueText = blueTextField.text, !blueText.isEmpty  else { return }
        if let number = Float(blueText) {
            blueSlider.value = number
            blueLabel.text = String(number)
        }
    }
}
