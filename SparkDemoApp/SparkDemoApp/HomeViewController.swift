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
            // ...
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    
    @IBAction func receiveMessage(_ sender: Any) {
        
        sparkSDK!.messages.list(roomId: "Y2lzY29zcGFyazovL3VzL1JPT00vMDkyMjMyY2UtODZiOC0zMTg5LTgyNjEtOTYxMjQ0MThmYTll", completionHandler: {
            response in
            
            for message in response.result.data!{
                print("\(message.personEmail!.toString()): \(message.text!)")
            }
            
        })
        
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
