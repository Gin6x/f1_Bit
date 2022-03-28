//
//  ViewController.swift
//  F1Bit
//
//  Created by Gin on 15/3/2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func  didTapButton() {
        let homeVC = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
        present(homeVC, animated: true, completion: nil)
    }

}

