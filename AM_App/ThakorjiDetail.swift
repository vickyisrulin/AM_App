//
//  ThakorjiDetail.swift
//  AM_App
//
//  Created by Vicky Rana on 3/5/17.
//  Copyright © 2017 Vicky Rana. All rights reserved.
//

import Foundation
import UIKit

class ThakorjiImage: UIViewController {
    
    var mandir = String()
    var date = String()
    var id = Int16()
    
    
    @IBOutlet weak var mandirLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        
        mandirLabel.text = mandir
        dateLabel.text = date
        
        print(id)
    }
}
