//
//  RankingViewController.swift
//  F1Bit
//
//  Created by Gin on 1/4/2022.
//

import UIKit

class RankingViewController: UIViewController {
    
    @IBOutlet weak var rankingButton: UIButton!
    @IBOutlet weak var seasonButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        initialF1ApiCall()
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
        selectionPickerVC.modalPresentationStyle = .overCurrentContext
        selectionPickerVC.modalTransitionStyle = .crossDissolve
        present(selectionPickerVC, animated: true, completion: nil)
    }
    
    @IBAction func seasonPickerButton(_ sender: UIButton) {
        let selectionPickerVC = storyboard?.instantiateViewController(withIdentifier: "SelectionPicker_VC") as! SelectionPickerViewController
        selectionPickerVC.rankselectionDelegate = self
        selectionPickerVC.modalPresentationStyle = .overCurrentContext
        selectionPickerVC.modalTransitionStyle = .crossDissolve
        present(selectionPickerVC, animated: true, completion: nil)
    }
}


extension RankingViewController: rankSelectionDelegate {
    func selectedOption(rank: String, season: String) {
        
        //Changing both button's title according to user's ranking selection through delegate
        rankingButton.setTitle(rank, for: .normal)
        seasonButton.setTitle(season, for: .normal)
        print("Selected \(rank) ranking in \(season) season")
        
        //Make api call using rank and season selections
        
        func callF1Api() {
            
            // Create URL Request
            let request = NSMutableURLRequest(url: NSURL(string: "https://api-formula-1.p.rapidapi.com/rankings/\(rank)?season=\(season)")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
            
            //Create request header
            let headers = [
                "x-rapidapi-host": "api-formula-1.p.rapidapi.com",
                "x-rapidapi-key": "6ecdce6c5amshe3e328919c857d9p15ec4cjsnedfd8e331d72"
            ]
            
            // Specify HTTP Method to use
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            //Create a URLSession and give different response
            let session = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                
                // Check if Error took place
                if let error = error {
                    print("There is an error: \(error.localizedDescription), please check the sever")
                    return
                }
                
                // Read HTTP Response Status code
                if let response = response as? HTTPURLResponse {
                    print("Response HTTP Status code: \(response.statusCode)")
                }
                
                // Convert HTTP Response Data to a simple String
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("Response data string:\n \(dataString)")
                }
            }
            
            session.resume()
        }
        callF1Api()
    }
}

//Initial api call, default calling: Drivers ranking in 2022
    func initialF1ApiCall() {
        
        // Create URL Request
        let request = NSMutableURLRequest(url: NSURL(string: "https://api-formula-1.p.rapidapi.com/rankings/drivers?season=2022")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        //Create request header
        let headers = [
            "x-rapidapi-host": "api-formula-1.p.rapidapi.com",
            "x-rapidapi-key": "6ecdce6c5amshe3e328919c857d9p15ec4cjsnedfd8e331d72"
        ]
        
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        //Create a URLSession and give different response
        let session = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            
            // Check if Error took place
            if let error = error {
                print("There is an error: \(error.localizedDescription), please check the sever")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }
        
        session.resume()
    }







