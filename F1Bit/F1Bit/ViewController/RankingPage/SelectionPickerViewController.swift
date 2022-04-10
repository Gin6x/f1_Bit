//
//  SelectionPickerViewController.swift
//  F1Bit
//
//  Created by Gin on 10/4/2022.
//

import UIKit

protocol rankSelectionDelegate {
    func selectedOption (rank: String, season: String)
}

class SelectionPickerViewController: UIViewController {
    
    var rankselectionDelegate: rankSelectionDelegate!
    
    @IBOutlet weak var selctionPickerStackView: UIStackView!
    @IBOutlet weak var rankingPickerView: UIPickerView!
    
    //Options for pickerView
    let ranks = ["Driver", "Team"]
    let seasons = ["2022", "2021", "2020"]
    var selectedRank = "Driver"
    var selectedSeason = "2022"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rankingPickerView.dataSource = self
        rankingPickerView.delegate = self
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButton (_ sender: UIBarButtonItem) {
//        rankselectionDelegate.selectedOption(rank: selectedRank, season: selectedSeason)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}

extension SelectionPickerViewController: UIPickerViewDataSource {
    
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
    
    //Change both textfield according to pickerView's option
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedRank = ranks[row]
            print(selectedRank)
        } else {
            selectedSeason = seasons[row]
            print(selectedSeason)
        }
        rankselectionDelegate.selectedOption(rank: selectedRank, season: selectedSeason)
    }
}

extension SelectionPickerViewController: UIPickerViewDelegate {}



