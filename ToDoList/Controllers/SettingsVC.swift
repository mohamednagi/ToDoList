//
//  SettingsVC.swift
//  ToDoList
//
//  Created by Sierra on 7/24/18.
//  Copyright © 2018 Nagiz. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class SettingsVC: UIViewController {
    override var prefersStatusBarHidden: Bool {return true}

    @IBOutlet weak var Switch: UISwitch!
    @IBOutlet weak var TaskName: UITextField!
    @IBOutlet var ColorBu: [UIButton]!
    @IBOutlet weak var CompletionDate: UIDatePicker!
    var stat: Bool!
    
    @IBAction func Switch(_ sender: UISwitch) {
        if Switch.isOn{
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { (success, error) in
                if error == nil{
                    self.TimedNotification(inSeconds: 1 , title:"" , body:"notifications switched on" ) { (success) in
                        if success{
                            self.Switch.setOn(true, animated: false)
                            self.stat=true
                            self.SaveStat()
                            print("Switch On")
                        } }
                    print("Auth is perfect")
                } }
        }else{
            Switch.setOn(false, animated: false)
            stat=false
            SaveStat()
            print("Switched Off")
        }
    }
    
    @IBAction func CategoryColorBu(_ sender: UIButton) {
        ColorBu.forEach { (color) in
            UIView.animate(withDuration: 0.3, animations: {
                color.isHidden = !color.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func ColorBuTapped(_ sender: UIButton) {
        guard let colorName = sender.currentTitle else{return}
        let color = colors(rawValue: colorName)
        switch color {
        case .black?:
            Color = "black"
            hideMe()
        case .darkgray?:
            Color = "darkgray"
            hideMe()
        case .gray?:
            Color = "gray"
            hideMe()
        case .brown?:
            Color = "brown"
            hideMe()
        case .yellow?:
            Color = "yellow"
            hideMe()
        case .green?:
            Color = "green"
            hideMe()
        case .red?:
            Color = "red"
            hideMe()
        default:
            Color = "white"
        }
    }
    
    @IBAction func SaveBu(_ sender: UIBarButtonItem) {
        if !(TaskName.text?.isEmpty)!{
            let newTask = Tasks(context: context)
            newTask.title = TaskName.text
            newTask.color = Color
            newTask.mySwitch = stat
            newTask.date = String(describing:CompletionDate.date)
            SaveItems()
            dismiss(animated: true, completion: nil)
        }else{
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func BackBu(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    func hideMe(){
        ColorBu.forEach { (color) in
            UIView.animate(withDuration: 0.3, animations: {
                color.isHidden = true
                self.view.layoutIfNeeded()
            })
        }
    }
    func SaveStat(){
        let newTask = Tasks(context: context)
        newTask.mySwitch=stat
        SaveItems()
    }
}
