//
//  DataViewController.swift
//  NutrientCaculator
//
//  Created by 林仲景 on 2023/4/8.
//

import UIKit

class DataViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var frequentOfExercisePicker: UIPickerView!
    
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var genderSelector: UISegmentedControl!
    
    @IBOutlet weak var dietCategorySelector: UISegmentedControl!
    
    @IBOutlet weak var caculateButton: UIButton!
    
    
    var excerciseFrequencyLists = [
        frequencyOfExercise.請選擇.rawValue,
        frequencyOfExercise.完全沒有運動習慣.rawValue,
        frequencyOfExercise.每周有1到3天的運動習慣.rawValue,
        frequencyOfExercise.每周有3到5天的運動習慣.rawValue,
        frequencyOfExercise.幾乎每天運動.rawValue ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frequentOfExercisePicker.delegate = self
        frequentOfExercisePicker.dataSource = self
        view.backgroundColor = UIColor(red: 114/255, green: 134/255, blue: 211/255, alpha: 1)
        heightTextField.delegate = self
        weightTextField.delegate = self
        ageTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    
        
    @IBSegueAction func infoTransferSegue(_ coder: NSCoder) -> ResultViewController? {
        let controller = ResultViewController(coder: coder)
        
        let height = Double(heightTextField.text!) ?? 0
        let weight = Double(weightTextField.text!) ?? 0
        let age = Double(ageTextField.text!) ?? 0
        let gender = genderSelector.selectedSegmentIndex
        let dietCategory = dietCategorySelector.selectedSegmentIndex
        
        
        if height>0.0, weight>0.0, age>0.0, exerciseFrequency != "請選擇"{
            controller?.userInfo = userInfo(height: height, weight: weight, age: age, gender: gender, dietCategory: dietCategory, exerciseFrequency: exerciseFrequency)
    
        }else{
            let alertController = UIAlertController(title: "數值有誤", message: "請確認輸入數值", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okButton)
            present(alertController, animated: true)
        }
        return controller
    }
}

//PickerViewDelegate
var exerciseFrequency = frequencyOfExercise.請選擇.rawValue
extension DataViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return excerciseFrequencyLists.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return excerciseFrequencyLists[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        exerciseFrequency = excerciseFrequencyLists[row]
        print(exerciseFrequency)
    }
}
