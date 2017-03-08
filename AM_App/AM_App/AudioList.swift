//
//  AudioList.swift
//  AM_App
//
//  Created by Vicky Rana on 3/7/17.
//  Copyright © 2017 Vicky Rana. All rights reserved.
//

import Foundation
import UIKit
import Alamofire



class AudioList: UITableViewController {
    
 
   // var lists = [list]()
    
    var AudioURL = "http://anoopam.org/api/ams/v2/fetch_images.php?feature=audio"
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
            print(readableJSON)
           // if let items = readableJSON["categories"] as? [JSONStandard]{
             //   for item in items {
                    
                    
               //     let name = item["catName"] as! String
                // print(name)
                //}
            //}
        }
        catch {
            print(error)
            
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAlamor(url: AudioURL)
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    
    
}
