//
//  Extensions.swift
//  ToDoList
//
//  Created by Sierra on 7/25/18.
//  Copyright © 2018 Nagiz. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

extension UIViewController {
    enum colors : String{
        case black,darkgray,gray,brown,yellow,green,red
    }
    
    func SaveItems(){
        do{
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
    }
    
    func LoadTasks(tableView:UITableView){
        let request:NSFetchRequest<Tasks> = Tasks.fetchRequest()
        do{
            TasksArray = try context.fetch(request)
            tableView.reloadData()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func AlertMe(){
        let alert = UIAlertController(title: "Error", message: "You have to insert task name", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func TimedNotification(inSeconds:TimeInterval ,title:String , body:String , completion: @escaping (_ success:Bool) -> ()){
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = title
        //content.subtitle = "subtitle one"
        content.body = body
        let request = UNNotificationRequest(identifier: "customNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if error == nil{
                completion(true)
            }else{
                completion(false)
            } } }
    
    func deleteDefaults(){
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }

}
