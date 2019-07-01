//
//  WorkOutVC.swift
//  LegDay
//
//  Created by Jay Bergonia on 07/01/2019.
//  Copyright © 2019 Jay Bergonia. All rights reserved.
//

import UIKit
import Intents

class WorkOutVC: UIViewController {
    
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.typeLbl.isHidden = true
        self.timerLbl.isHidden = true
        
        //needs developer program to enable at project capabilities XD
        INPreferences.requestSiriAuthorization { (status) in
            switch status {
            case .authorized:
                print("authorized")
            case .denied:
                print("denied")
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            default:
                print("default")
            }
        }
        
        
    }
    
    
}

