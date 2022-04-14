//
//  RankingViewController.swift
//  F1Bit
//
//  Created by Gin on 1/4/2022.
//

import UIKit

struct apiData: Codable {
    let response: [rankingData]
        
    struct rankingData: Codable {
        let position: Int
        
        struct driver: Codable {
            let name: String
//            let image: URL
        }
        struct team: Codable {
//            let name: String
            let logo: URL
        }
        
        let point: Int
    }
}

class RankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var rankingButton: UIButton!
    @IBOutlet weak var seasonButton: UIButton!
    @IBOutlet weak var rankingTableView: UITableView!
    
    //Data model for cell display
    let f1Teams = ["Mercedes-AMG Petronas", "Red Bull Racing", "Scuderia Ferrari", "McLaren Racing", "Alpine F1 Team"]
    
    // cell reuse id
    let cellReuseIdentifier = "teamCell"
    let cellSpacingHeight: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialF1ApiCall()
        
        //Register the table view cell class and its reuse id
        self.rankingTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        rankingTableView.delegate = self
        rankingTableView.dataSource = self
        rankingTableView.layer.cornerRadius = 10
        //        getOptions()
    }
//    func getOptions() {
//
//        let options = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5", "Option 6", "Option 7"]
//        let ids = [0, 1, 2, 3, 4, 5, 6]
//
//        self.driverBtn.setOptions(options: options, optionIds: ids, selectedIndex: 0)
//    }
    //=================================================rankingTableView================================================================//
    
    // number of section for each cell
    func numberOfSections(in tableView: UITableView) -> Int {
            return self.f1Teams.count
        }
    
    // number of rows in table view
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
    
    // set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
        }
    
    // Make the background color show through
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    
    // create a cell for each table view row
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            // create a new cell if needed or reuse an old one
            let teamCell:UITableViewCell = (self.rankingTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
            
            // set the text from the data model
            teamCell.textLabel?.text = self.f1Teams[indexPath.section]
            
            // add border and color
            teamCell.backgroundColor = UIColor.white
            teamCell.layer.borderColor = UIColor.black.cgColor
            teamCell.layer.borderWidth = 1
            teamCell.layer.cornerRadius = 8
            teamCell.clipsToBounds = true

            return teamCell
        }
    
    //=====================================================rankingTableView==================================================================//
    
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







