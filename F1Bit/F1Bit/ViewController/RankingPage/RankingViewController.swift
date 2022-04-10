//
//  RankingViewController.swift
//  F1Bit
//
//  Created by Gin on 1/4/2022.
//

import UIKit

class RankingViewController: UIViewController {

    @IBOutlet var ranksTextField: UITextField!
    @IBOutlet var seasonsTextField: UITextField!
    @IBOutlet weak var rankingButton: UIButton!
    @IBOutlet weak var seasonButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        getOptions()
    }
//    func getOptions() {
//
//        let options = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5", "Option 6", "Option 7"]
//        let ids = [0, 1, 2, 3, 4, 5, 6]
//
//        self.driverBtn.setOptions(options: options, optionIds: ids, selectedIndex: 0)
//    }
    
    @IBAction func rankingPickerButton(_ sender: UIButton) {
        let selectionPickerVC = storyboard?.instantiateViewController(withIdentifier: "SelectionPicker_VC") as! SelectionPickerViewController
        selectionPickerVC.rankselectionDelegate = self
    }
    
    @IBAction func seasonPickerButton(_ sender: UIButton) {
        let selectionPickerVC = storyboard?.instantiateViewController(withIdentifier: "SelectionPicker_VC") as! SelectionPickerViewController
        selectionPickerVC.rankselectionDelegate = self
    }
}

extension RankingViewController: rankSelectionDelegate {
    func selectedOption(rank: String, season: String) {
        rankingButton.titleLabel?.text = rank
        seasonButton.titleLabel?.text = season
    }
}






