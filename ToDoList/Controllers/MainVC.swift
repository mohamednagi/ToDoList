//
//  ViewController.swift
//  ToDoList
//
//  Created by Sierra on 7/24/18.
//  Copyright © 2018 Nagiz. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class MainVC: UIViewController {

    @IBOutlet weak var TableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LoadTasks(tableView:TableView)
      //  deleteCell(index: 0)
    }
    func deleteCell(index:Int){
        context.delete(TasksArray[index])
        do{
            try context.save()
            TasksArray.remove(at: index)
        }catch{
            print(error.localizedDescription)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        LoadTasks(tableView:TableView)
    }
    
    @IBAction func AddBu(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: add, sender: self)
    }
    
    
    @IBAction func SettingsBu(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: settings, sender: self)
    }
}

extension MainVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TasksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: CellId, for: indexPath) as! MainCell
        let item = TasksArray[indexPath.row]
        cell.accessoryType = item.done ? .checkmark : .none
        cell.Title.text = TasksArray[indexPath.row].title
            cell.CompletionDate.text = TasksArray[indexPath.row].date
            let now = Date()
            let completion = TasksArray[indexPath.row].date
        if completion != nil{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
            let date = dateFormatter.date(from: completion!)!
            let newdiff =  Calendar.current.compare(date, to: now, toGranularity: .day)
            if newdiff.rawValue == 0{
                TimedNotification(inSeconds: 1 , title:TasksArray[indexPath.row].title! ,body:"Completion Date Done" , completion: { (success) in
                    item.done = true
                })
            }
        }
        
        let taskColor = TasksArray[indexPath.row].color
        switch taskColor {
        case "black"?:
            cell.backgroundColor = .black
            cell.Title.textColor = .white
            cell.CompletionDate.textColor = .white
        case "darkgray"?:
            cell.backgroundColor = .darkGray
            cell.Title.textColor = .white
            cell.CompletionDate.textColor = .white
        case "gray"?:
            cell.backgroundColor = .gray
            cell.Title.textColor = .white
            cell.CompletionDate.textColor = .white
        case "brown"?:
            cell.backgroundColor = .brown
            cell.Title.textColor = .white
            cell.CompletionDate.textColor = .white
        case "yellow"?:
            cell.backgroundColor = .yellow
        case "green"?:
            cell.backgroundColor = .green
        case "red"?:
            cell.backgroundColor = .red
        default:
            cell.backgroundColor = .white
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let index = indexPath.row
        defaults.set(index, forKey: key)
        performSegue(withIdentifier: edit, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // delete task by swipe
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(TasksArray[indexPath.row])
            do{
                try context.save()
                TasksArray.remove(at: indexPath.row)
                TableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
