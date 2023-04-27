//
//  ResultViewController.swift
//  NutrientCaculator
//
//  Created by 林仲景 on 2023/4/8.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var bmrLabel: UILabel!
    
    @IBOutlet weak var tdeeLabel: UILabel!
    
    @IBOutlet weak var carbohydrateLabel: UILabel!
    
    @IBOutlet weak var proteinLabel: UILabel!
    
    @IBOutlet weak var lipidLabel: UILabel!
    
    var userInfo:userInfo!
    var bmr = 0.0
    var tdee = 0.0
    /*
    ● 男性： (10 × 公斤體重) + (6.25 × 公分身高) - (5 × 年齡歲數) + 5
    ● 女性： (10 × 公斤體重) + (6.25 × 公分身高) - (5 × 年齡歲數) – 161
     */
    
    func bmrcaculation()->String{
        let weightParameter = 10 * userInfo.weight
        let heightParameter = 6.25 * userInfo.height
        let ageParameter = 5 * userInfo.age
        if userInfo.gender == 0{
            bmr = weightParameter + heightParameter - ageParameter + 5
        }else{
            bmr = weightParameter + heightParameter - ageParameter - 161
        }
        return String(bmr)
    }
    
    /*
     ● 坐式生活，完全沒有運動習慣：BMR x 1.2
     ● 輕度活動，每周有 1 - 3 天的運動習慣：BMR x 1.4
     ● 中度活動，每周有 3 - 5 天的運動習慣：BMR x 1.6
     ● 高度活動，每周有 6 - 7 天的運動習慣：BMR x 1.8
     */
     
    func tdeeCaculation()->String{
        let exerciseFrequency = userInfo.exerciseFrequency
        switch exerciseFrequency{
        case frequencyOfExercise.完全沒有運動習慣.rawValue:
            tdee = bmr*1.2
        case frequencyOfExercise.每周有1到3天的運動習慣.rawValue:
            tdee = bmr*1.4
        case frequencyOfExercise.每周有3到5天的運動習慣.rawValue:
            tdee = bmr*1.6
        case frequencyOfExercise.幾乎每天運動.rawValue:
            tdee = bmr*1.8
        default:
            print("請選擇運動頻率")
        }
        return String(tdee)
    }
    
    func nutrientCaculation()->[Double]{
        var carbohydrate = 0.0
        var protein = 0.0
        var lipid = 0.0
        if userInfo.dietCategory == 0{
            carbohydrate = (tdee+100)*0.55/4
            protein = (tdee+100)*0.25/4
            lipid = (tdee+100)*0.20/9
            
        }else{
            carbohydrate = (tdee-100)*0.40/4
            protein = (tdee-100)*0.35/4
            lipid = (tdee-100)*0.25/9
        }
        return [carbohydrate, protein, lipid]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmrLabel.text = bmrcaculation()
        tdeeLabel.text = tdeeCaculation()
        let nutrientComponents = nutrientCaculation()
        carbohydrateLabel.text = String(format: "%.1f", nutrientComponents[0])
        proteinLabel.text = String(format: "%.1f", nutrientComponents[1])
        lipidLabel.text = String(format: "%.1f", nutrientComponents[2])
    }
    

    
}
