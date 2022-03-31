//
//  HomeViewController.swift
//  F1Bit
//
//  Created by Gin on 28/3/2022.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    @IBAction func IntroBtn(_ sender: UIButton) {
        let introVC = storyboard?.instantiateViewController(withIdentifier: "Intro_VC") as! IntroViewController
        self.navigationController?.pushViewController(introVC, animated: true)
    }
    
    @IBAction func CircuitBtn(_ sender: UIButton) {
        let circuitVC = storyboard?.instantiateViewController(withIdentifier: "Circuit_VC") as! CircuitViewController
        self.navigationController?.pushViewController(circuitVC, animated: true)
    }
    
    @IBAction func DriverBtn(_ sender: UIButton) {
        let driverVC = storyboard?.instantiateViewController(withIdentifier: "Driver_VC") as! DriverViewController
        self.navigationController?.pushViewController(driverVC, animated: true)
    }
}
