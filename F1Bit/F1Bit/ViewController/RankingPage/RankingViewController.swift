//
//  RankingViewController.swift
//  F1Bit
//
//  Created by Gin on 1/4/2022.
//

import UIKit

class RankingViewController: UIViewController {
    
    @IBOutlet var rankingPickerView: UIPickerView!
    @IBOutlet var ranksTextField: UITextField!
    @IBOutlet var seasonsTextField: UITextField!
    
    //Options for pickerView
    let ranks = ["Driver", "Team", "YOMAN"]
    let seasons = ["2022", "2021", "2020"]
    var whichRank = "Driver"
    var whichSeason = "2022"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rankingPickerView.dataSource = self
        rankingPickerView.delegate = self
        
        ranksTextField.inputView = rankingPickerView
        seasonsTextField.inputView = rankingPickerView
        ranksTextField.text = "\(whichRank)"
        seasonsTextField.text = "\(whichSeason)"
        
        //        getOptions()
    }
//    func getOptions() {
//
//        let options = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5", "Option 6", "Option 7"]
//        let ids = [0, 1, 2, 3, 4, 5, 6]
//
//        self.driverBtn.setOptions(options: options, optionIds: ids, selectedIndex: 0)
//    }
}

extension RankingViewController: UIPickerViewDataSource {
    
    //How many components to select
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    //How many row in each component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return ranks.count
        }
        
        return seasons.count
    }
    
    //Set title for each row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return ranks[row]
        }
        
        return seasons[row]
    }
    
    //Use "whichRank" && "whichSeason" to see user's final choice
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            whichRank = ranks[row]
        } else {
            whichSeason = seasons[row]
        }
    }
    
}

extension RankingViewController: UIPickerViewDelegate {}


