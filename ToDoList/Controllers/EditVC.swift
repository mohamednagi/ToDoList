//
//  EditVC.swift
//  ToDoList
//
//  Created by Sierra on 7/26/18.
//  Copyright © 2018 Nagiz. All rights reserved.
//

import UIKit
import CoreData

class EditVC: UIViewController {
    override var prefersStatusBarHidden: Bool {return true}

    var index = defaults.integer(forKey: key)
    @IBOutlet weak var TaskName: UITextField!
    @IBOutlet weak var CompletionDate: UIDatePicker!
    @IBOutlet var CategoryColors: [UIButton]!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deleteDefaults()
    }
    
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
            updateCell()
            deleteCell(index: index)
            dismiss(animated: true, completion: nil)
    }
    
    @IBAction func DeleteBu(_ sender: UIButton) {
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this task!", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let delete = UIAlertAction(title: "delete", style: .destructive) { (success) in
            self.deleteCell(index: self.index)
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancel)
        alert.addAction(delete)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func UndoBu(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
    extension EditVC {
        
        func deleteCell(index:Int){
            context.delete(TasksArray[index])
            do{
                try context.save()
                TasksArray.remove(at: index)
            }catch{
                print(error.localizedDescription)
            }
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
