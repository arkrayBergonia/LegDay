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
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleSiriRequest), name: NSNotification.Name("workoutStartedNotification"), object: nil)
        
        //needs developer program to enable at project capabilities XD
        INPreferences.requestSiriAuthorization { (status) in
            switch status {
            case .authorized:
                print("requestSiriAuthorization - authorized")
            case .denied:
                print("requestSiriAuthorization - denied")
            case .notDetermined:
                print("requestSiriAuthorization - notDetermined")
            case .restricted:
                print("requestSiriAuthorization - restricted")
            default:
                print("requestSiriAuthorization - default")
            }
        }
        
        
    }
    
    @objc func handleSiriRequest() {
        guard let intent = DataService.instance.startWorkoutIntent, let goalValue = intent.goalValue, let workoutType = intent.workoutName?.spokenPhrase else {
            timerLbl.isHidden = true
            typeLbl.isHidden = true
            return
        }
        
        typeLbl.isHidden = false
        timerLbl.isHidden = false
        
        typeLbl.text = "TYPE: \(workoutType.capitalized)"
        timerLbl.text = "\(goalValue.convertToClockTime()) LEFT"
    }
    
}

