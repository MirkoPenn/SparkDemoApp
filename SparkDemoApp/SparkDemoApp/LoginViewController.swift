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
        let clientSecret = "4fb103707e416f6bff9dcbe441feeeebd0e6101db4f4beaa1aae312afa7ff78a"
        let scope = "spark:all"
        let redirectUri = "Sparkdemoapp://response"
        
        let authenticator = OAuthAuthenticator(clientId: clientId, clientSecret: clientSecret, scope: scope, redirectUri: redirectUri)
        let spark = Spark(authenticator: authenticator)
        
        if !authenticator.authorized {
            authenticator.authorize(parentViewController: self) { success in
                if !success {
                    print("User not authorized")
                }
            }
        }
    }
}

