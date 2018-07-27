//
//  AddTaskVC.swift
//  ToDoList
//
//  Created by Sierra on 7/24/18.
//  Copyright © 2018 Nagiz. All rights reserved.
//

import UIKit
import CoreData

class AddTaskVC: UIViewController {
    override var prefersStatusBarHidden: Bool {return true}

    @IBOutlet weak var TaskName: UITextField!
    @IBOutlet weak var CompletionDate: UIDatePicker!
    @IBOutlet var CategoryColors: [UIButton]!
    
    @IBAction func CategoryColorBu(_ sender: UIButton) {
        CategoryColors.forEach { (color) in
            UIView.animate(withDuration: 0.3, animations: {
                color.isHidden = !color.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func ColorTapped(_ sender: UIButton) {
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
        if (TaskName.text?.isEmpty)! {
            AlertMe()
        }else{
            updateCell()
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func BackBu(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func hideMe(){
        CategoryColors.forEach { (color) in
            UIView.animate(withDuration: 0.3, animations: {
                color.isHidden = true
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func updateCell(){
        let newTask = Tasks(context: context)
        newTask.title = TaskName.text
        newTask.color = Color
        newTask.date = String(describing:CompletionDate.date)
        newTask.mySwitch = true
        SaveItems()
    }
}
