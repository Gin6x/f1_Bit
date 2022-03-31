//
//  ViewController.swift
//  F1Bit
//
//  Created by Gin on 15/3/2022.
//

import UIKit

class LaunchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func  didTapButton() {
        let tabBarC = storyboard?.instantiateViewController(withIdentifier: "TabBar_C") as! UITabBarController
        present(tabBarC, animated: true, completion: nil)
    }

}

