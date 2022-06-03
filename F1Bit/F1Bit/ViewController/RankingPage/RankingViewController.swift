//
//  RankingViewController.swift
//  F1Bit
//
//  Created by Gin on 1/4/2022.
//

import UIKit

struct RankingData: Codable {
    let get: String
    struct Parameters: Codable {
        let season: String
    }
    let parameters: Parameters
    let results: Int
    var response: [ResponseData]
}

struct ResponseData: Codable {
    let position: Int
    struct Driver: Codable {
        let name: String
        let image: URL
    }
    let driver: Driver?
    struct Team: Codable {
        let name: String
        let logo: URL
    }
    let team: Team
    let points: Int?
}

class RankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var rankingButton: UIButton!
    @IBOutlet weak var seasonButton: UIButton!
    @IBOutlet weak var rankingTableView: UITableView!
    @IBOutlet weak var rankingTableViewCell: RankingTableViewCell!
    
    //Data model for cell display
    var positionArray: [String] = []
    var teamlogoUIImageView = UIImageView()
    var teamlogoArray: [UIImageView] = []
    var drivernamesArray: [String] = []
    var teamnamesArray: [String] = []
    var driverpointsArray: [String] = []
    var teampointsArray: [String] = []

    // cell reuse id
    let cellReuseIdentifier = "rankCell"
    let cellSpacingHeight: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultF1ApiCall()
        
        //Register the table view cell class and its reuse id
//        self.rankingTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        rankingTableView.delegate = self
        rankingTableView.dataSource = self
        rankingTableView.layer.cornerRadius = 10
    }
    //=================================================rankingTableView================================================================//
    
    // number of section for each cell
    func numberOfSections(in tableView: UITableView) -> Int {
        if (rankingButton.titleLabel?.text == "teams") {
            return self.teamnamesArray.count
        }
        
        return self.drivernamesArray.count
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
            rankingTableViewCell = rankingTableView.dequeueReusableCell(withIdentifier: "rankCell")! as UITableViewCell as? RankingTableViewCell
            
            // set all info of cell from the data model
            rankingTableViewCell.positionLabel.text? = self.positionArray[indexPath.section]
            rankingTableViewCell.teamLogoUIImageView = self.teamlogoArray[indexPath.section]
            
            
            //Shown different name on Label according to choice between drivers and teams
            if (rankingButton.titleLabel?.text == "teams") {
                rankingTableViewCell.nameLabel.text? = self.teamnamesArray[indexPath.section]
                rankingTableViewCell.pointsLabel.text = self.teampointsArray[indexPath.section]
            } else if (rankingButton.titleLabel?.text == "drivers"){
                rankingTableViewCell.nameLabel.text? = self.drivernamesArray[indexPath.section]
                rankingTableViewCell.pointsLabel.text? = self.driverpointsArray[indexPath.section]
            }
            
            
            // add border and color
            rankingTableViewCell.backgroundColor = UIColor.white
            rankingTableViewCell.layer.borderColor = UIColor.black.cgColor
            rankingTableViewCell.layer.borderWidth = 1
            rankingTableViewCell.layer.cornerRadius = 8
            rankingTableViewCell.clipsToBounds = true

            return rankingTableViewCell
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

//Delegate method for selection of ranking and years
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
            let task = URLSession.shared.dataTask(with: request as URLRequest){ [self] (data, response, error) in
                
                let decoder = JSONDecoder()
                
                if let error = error {
                    print("There is an error: \(error.localizedDescription), please check the sever")
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    print("Response HTTP Status code: \(response.statusCode)")
                }

                if let data = data, let rankingDatas = try? decoder.decode(RankingData.self, from: data) {
                    print(rankingDatas.response)
                    for datas in rankingDatas.response {
                        self.positionArray.append("\(datas.position)")
                                                
                        if (self.rankingButton.titleLabel?.text == "teams") {
                            self.teamnamesArray.append("\(datas.team.name)")
                            self.teampointsArray.append("\(datas.points ?? 0)")
                        } else if (self.rankingButton.titleLabel?.text == "drivers") {
                            self.drivernamesArray.append("\(datas.driver?.name ?? "No data")")
                            self.driverpointsArray.append("\(datas.points ?? 0)")
                        }
                        
                    }
                }; DispatchQueue.main.sync {
                    self.rankingTableView.reloadData()
                }
            }.resume()
        }
        callF1Api()
    }
}


//Initial api call, default calling: Drivers ranking in 2022
extension RankingViewController {
    func defaultF1ApiCall() {
        
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
        let task = URLSession.shared.dataTask(with: request as URLRequest){ (data, response, error) in
            
            let decoder = JSONDecoder()
            
            if let error = error {
                print("There is an error: \(error.localizedDescription), please check the sever")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }

            if let data = data, let rankingDatas = try? decoder.decode(RankingData.self, from: data) {
                print(rankingDatas.response)
                for datas in rankingDatas.response {
                    
                    if let teamlogoData = try? Data(contentsOf: datas.team.logo) {
                        if let teamlogoImage = UIImage(data: teamlogoData) {
                            self.teamlogoUIImageView.image = teamlogoImage
                            self.teamlogoArray.append(self.teamlogoUIImageView)
                        }
                    }
                    self.positionArray.append("\(datas.position)")
                    self.drivernamesArray.append("\(datas.driver?.name ?? "No data")")
                    self.driverpointsArray.append("\(datas.points ?? 0)")
                }
            }; DispatchQueue.main.sync {
                self.rankingTableView.reloadData()
            }
        }.resume()
    }
}
        
        //Create a URLSession and give different response
        
//        let session = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
//
//            // Check if Error took place
//            if let error = error {
//                print("There is an error: \(error.localizedDescription), please check the sever")
//                return
//            }
//
//            // Read HTTP Response Status code
//            if let response = response as? HTTPURLResponse{
//                print("Response HTTP Status code: \(response.statusCode)")
//            }
//
//             //Convert HTTP Response Data to a simple String
//            if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                print("Response data string:\n \(dataString)")
//            }
//        }.resume()
        
        //try new codable method
//        let session = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
//            let decoder = JSONDecoder()
//
//            if let response = response as? HTTPURLResponse {
//                print("Response HTTP Status code: \(response.statusCode)")
//            }
//            if let data = data {
//                do {
//                    let RankingDatas = try decoder.decode(RankingData.self, from: data)
//                    print(RankingDatas.response)
//
//
//                } catch {
//                    print(error)
//                }
//            }
//        }.resume()
//    }
