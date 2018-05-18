//
//  HomeViewController.swift
//  SparkDemoApp
//
//  Created by Mirko Pennone on 18/05/18.
//  Copyright © 2018 com.example. All rights reserved.
//

import UIKit
import SparkSDK

class HomeViewController: UIViewController {

    var sparkSDK: Spark?
    
    var userId: String?
    
    var roomId: String?
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.sparkSDK?.people.getMe() {[weak self] response in
            if let strongSelf = self {
                switch response.result {
                case .success(let person):
                    self?.userId = person.id
                    self?.welcomeLabel.text = "Welcome, \(person.displayName ?? "???")"
                case .failure:
                    self?.welcomeLabel.text = "Fetching user profile failed."
                }
            }
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendMessage(_ sender: Any) {
        sparkSDK!.messages.post(personEmail: EmailAddress.fromString("simon_pen@hotmail.it")!, text: "tattaaaaaaaa") { response in
            switch response.result {
            case .success(let message):
                print("Sent! Message: \(message)")
                self.roomId = message.roomId!
            // ...
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    
    @IBAction func receiveMessage(_ sender: Any) {
    

        
//        sparkSDK!.people.list(email: EmailAddress.fromString("simon_pen@hotmail.it")!, displayName: nil, max: nil, queue: DispatchQueue.main, completionHandler: { response in
//            
//            for person in response.result.data!{
//                print(person.id)
//            }
//            
//        })
//
        if let _ = roomId {
            
            sparkSDK!.messages.list(roomId: roomId!, completionHandler: {
                response in
                
                for message in response.result.data!{
                    print("\(message.personEmail!.toString()): \(message.text!)")
                }
                
            })
            
        } else {
            
            print("Send a message before receiving")
        }
        
    }
    
    @IBAction func createRoom(_ sender: Any) {
        
        
        sparkSDK!.rooms.create(title: "Assistenza") { (response) in
            
            
            self.sparkSDK!.memberships.create(roomId: response.result.data!.id!, personEmail: EmailAddress.fromString("simon_pen@hotmail.it")!, completionHandler: { (response) in
                
                print(response.result.data!.roomId!)
                
            })
        }
        
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
