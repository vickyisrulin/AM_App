//
//  FirstViewController.swift
//  TestTabbedApp
//
//  Created by Vicky Rana on 3/5/17.
//  Copyright © 2017 Vicky Rana. All rights reserved.
//

import UIKit
import Alamofire


struct post{
    let image : UIImage
    let name : String
    let count : Int16
    let date : String
    let id: Int16
    
}

class FirstViewController: UITableViewController {
    
    var Thakorji = [post]()
    
    var ThakorjiTodayURL = "http://anoopam.org/api/ams/v2/thakorji.php?f=1"
    typealias JSONStandard = [String :AnyObject]
    
    
    func callAlamor(url : String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            
            self.parseData(JSONData: response.data!)
        })
    }
    
    func parseData(JSONData: Data) {
        do {
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData , options: .mutableContainers) as! JSONStandard
            if let items = readableJSON["temples"] as? [JSONStandard]{
                for item in items {
                    
                    
                    let name = item["templePlace"] as! String
                    
                    let ThakorjiURL = URL(string: item["mainImage"] as! String)
                    let ThakorjiData = NSData(contentsOf: ThakorjiURL!)
                    let ThakorjiImage = UIImage(data: ThakorjiData as! Data)
                    
                    
                    let todaysDate = item["lastUpdatedTimestamp"] as! String
                    
                    let count = item["imageCount"] as! Int16
                    let temple_id = item["templeID"] as! Int16
                        
                    Thakorji.append(post.init(image: ThakorjiImage!, name: name, count: count,date: todaysDate,id:temple_id
                    ))
                    
                    self.tableView.reloadData()
                }
                
            }
            
        }
            
        catch {
            print(error)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAlamor(url: ThakorjiTodayURL)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Thakorji.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")//, for: indexPath)
        
        let ThakorjiImageview = cell?.viewWithTag(2) as! UIImageView
        ThakorjiImageview.image = Thakorji[indexPath.row].image
        
        let Location = cell?.viewWithTag(1) as! UILabel
        Location.text = Thakorji[indexPath.row].name
        
        let date = cell?.viewWithTag(3) as! UILabel
        date.text = Thakorji[indexPath.row].date
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let selectedRow = self.tableView.indexPathForSelectedRow!.row
        
        let ThakorjiView = segue.destination as? ThakorjiImage
        
        ThakorjiView?.date = Thakorji[selectedRow].date
        ThakorjiView?.mandir = Thakorji[selectedRow].name
        ThakorjiView?.id = Thakorji[selectedRow].id
        ThakorjiView?.count = Thakorji[selectedRow].count
    }
    
    
    
}

