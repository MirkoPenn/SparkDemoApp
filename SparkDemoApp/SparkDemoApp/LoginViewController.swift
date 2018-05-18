//
//  ViewController.swift
//  SparkDemoApp
//
//  Created by Mirko Pennone on 18/05/18.
//  Copyright © 2018 com.example. All rights reserved.
//

import UIKit
import SparkSDK

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginWithSpark(sender: AnyObject) {
        let clientId = "C60bf884e885ab74370102995e932f073d0c98ce2ff05fe453a203d1f677aeefd"
        let clientSecret = "1a0dd38ae30a990ee1c5ad0618c6db37451d1d413d56d52da48cfeb3659acf50"
        let scope = "spark:all"
        let redirectUri = "SparkDemoApp://response"
        
        let authenticator = OAuthAuthenticator(clientId: clientId, clientSecret: clientSecret, scope: scope, redirectUri: redirectUri)
        let spark = Spark(authenticator: authenticator)
        
        print("authorizing")
        
        authenticator.authorize(parentViewController: self) { success in
                
            if !success {
                    
                print("User not authorized")
                    
            } else {
                    
                print("User authorized.")
                    
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
                homeViewController.sparkSDK = spark
                self.navigationController?.pushViewController(homeViewController, animated: true)
            }
        }
    }
}

