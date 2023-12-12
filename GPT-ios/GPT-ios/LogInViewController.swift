//
//  LogInViewController.swift
//  GPT-ios
//
//  Created by Jingkun Liu on 12/12/23.
//

import Foundation
import UIKit

import Firebase
import GoogleSignIn

class LogInViewController: UIViewController {
    
    var loginHandle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loginHandle = AuthManager.shared.addLoginObserver {
            print("Login Complete")
            self.performSegue(withIdentifier: SHOW_LIST_SEGUE_ID, sender: self)
        }
        
        self.performSegue(withIdentifier: SHOW_LIST_SEGUE_ID, sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AuthManager.shared.removeObserver(self.loginHandle)
    }
    
    @IBAction func LogInButtonPressed(_ sender: Any) {
        print("Pressed Log In Button")
    }
}
