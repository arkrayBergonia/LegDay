//
//  WorkOutVC.swift
//  LegDay
//
//  Created by Jay Bergonia on 07/01/2019.
//  Copyright © 2019 Jay Bergonia. All rights reserved.
//

import UIKit
import Intents
import IntentsUI

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
        
        if #available(iOS 12.0, *) {
            addSiriButton(to: view)
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
    
    //MARK: SiriKit Shortcuts Implementation - addSiriButton
    func addSiriButton(to view: UIView) {
        if #available(iOS 12.0, *) {
            let button = INUIAddVoiceShortcutButton(style: .whiteOutline)
            button.shortcut = INShortcut(intent: intent )
            button.delegate = self

            button.translatesAutoresizingMaskIntoConstraints = false

            view.addSubview(button)
            view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
            view.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            print("SiriKit Shortcuts Implementation NOT AVAILABLE FOR THIS IOS VERSION")
        }
    }
}

@available(iOS 12.0, *)
extension WorkOutVC {
    public var intent: TestIntent {
        let testIntent = TestIntent()
        testIntent.myTestParameter = "my test intent"
        testIntent.suggestedInvocationPhrase = "Test Intent"
        return testIntent
    }
}

@available(iOS 12.0, *)
extension WorkOutVC: INUIAddVoiceShortcutButtonDelegate {
    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        addVoiceShortcutViewController.delegate = self
        addVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(addVoiceShortcutViewController, animated: true, completion: nil)
    }
    
    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        editVoiceShortcutViewController.delegate = self
        editVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(editVoiceShortcutViewController, animated: true, completion: nil)
    }
    
    
}

@available(iOS 12.0, *)
extension WorkOutVC: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}

@available(iOS 12.0, *)
extension WorkOutVC: INUIEditVoiceShortcutViewControllerDelegate {
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
