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
    
    //All options for pickerView
    let ranks = ["drivers", "teams"]
    let seasons = ["2022", "2021", "2020"]
    
    //Initial options are shown as below
    var selectedRank = "drivers"
    var selectedSeason = "2022"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rankingPickerView.dataSource = self
        rankingPickerView.delegate = self
        selctionPickerStackView.layer.cornerRadius = 10
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButton (_ sender: UIBarButtonItem) {
        rankselectionDelegate.selectedOption(rank: selectedRank, season: selectedSeason)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}

extension SelectionPickerViewController: UIPickerViewDataSource {
    
    //How many components to select
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    //Set row in each component
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
    
    //Get both selections
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedRank = ranks[row]
        } else {
            selectedSeason = seasons[row]
        }
    }
}

extension SelectionPickerViewController: UIPickerViewDelegate {}



