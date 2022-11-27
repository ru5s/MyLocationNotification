//
//  ViewController.swift
//  MyLocalNotification
//
//  Created by Ruslan Ismailov on 27/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    let center = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()
    
    var timeIntervar: Double?
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var countLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        center.delegate = self
        
        center.requestAuthorization(options: [.sound, .alert]) { granted, error in
            print("access to send nofification is \(granted)")
        }
        
        content.title = "Your notification send"
        content.body = "This very important text"
        content.sound = UNNotificationSound.default
        
        
    }
    
    @IBAction func stepperAction(_ sender: Any) {
        countLabel.text = String(Int(stepper.value))
        timeIntervar = stepper.value
        
    }
    
    
    @IBAction func btnAction(_ sender: Any) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeIntervar!, repeats: false)
        let uuid = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        
        center.add(request) { error in
            print("Ok")
        }
    }
    

}

extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
    }
    
    
}

