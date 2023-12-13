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
    
    @IBOutlet weak var googleSignIn: GIDSignInButton!
    
    var loginHandle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loginHandle = AuthManager.shared.addLoginObserver {
            print("Login Complete")
            print("UID: \(AuthManager.shared.currentUser?.uid ?? "")")
            
            self.performSegue(withIdentifier: SHOW_LIST_SEGUE_ID, sender: self)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        AuthManager.shared.removeObserver(self.loginHandle)
    }
    
    @IBAction func LogInButtonPressed(_ sender: Any) {
        print("Pressed Log In Button")
        
        self.performSegue(withIdentifier: SHOW_LIST_SEGUE_ID, sender: self)
    }
    
    @IBAction func googleSignInPressed(_ sender: Any) {
        print("Pressed Google Sign In Button")
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
            guard error == nil else {
                return
            }
            
            guard
                let user = result?.user,
                let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            
            AuthManager.shared.signInWithGoogleCredential(credential)
        }
    }
}
