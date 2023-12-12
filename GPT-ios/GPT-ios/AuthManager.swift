//
//  AuthManager.swift
//  GPT-ios
//
//  Created by Jingkun Liu on 12/12/23.
//

import Foundation

import Firebase
import GoogleSignIn

class AuthManager {
    
    static let shared = AuthManager()
    
    private init() {}
    
    var currentUser: User? {
            Auth.auth().currentUser
        }
        
        var isSignedIn: Bool {
            currentUser != nil
        }
        
        func addLoginObserver(callback: @escaping (() -> Void)) -> AuthStateDidChangeListenerHandle {
            return Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil {
                    callback()
                }
            }
        }
        
        func addLogoutObserver(callback: @escaping (() -> Void)) -> AuthStateDidChangeListenerHandle {
            return Auth.auth().addStateDidChangeListener { auth, user in
                if user == nil {
                    callback()
                }
            }
        }
        
        func removeObserver(_ authDidChangeHandle: AuthStateDidChangeListenerHandle?) {
            //        if authDidChangeHandle != nil {
            //            Auth.auth().removeStateDidChangeListener(authDidChangeHandle)
            //        }
            if let authHandle = authDidChangeHandle {
                Auth.auth().removeStateDidChangeListener(authHandle)
            }
        }
        
        func signInNewEmailPasswordUser(email: String, password: String) {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, err in
                if let error = err {
                    print("ERROR: creating user failed \(error)")
                    return
                } else {
                    print("User created")
                }
            }
        }
        
        func logInExistingEmailPasswordUser(email: String, password: String) {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, err in
                if let error = err {
                    print("ERROR: signning in failed \(error)")
                    return
                } else {
                    print("User signed in \(authResult?.user.uid ?? "")")
                }
            }
        }
        
        func signInAnonymously() {
            Auth.auth().signInAnonymously() { authResult, err in
                if let error = err {
                    print("ERROR: signning in failed \(error)")
                    return
                } else {
                    print("User signed in \(authResult?.user.uid ?? "")")
                }
            }
        }
        
        func signInwithRoseifreToken(_ rosefireToken: String) {
            Auth.auth().signIn(withCustomToken: rosefireToken) { res, err in
                if let err = err {
                    print("Error: \(err)")
                    return
                }
                
                print("Signed in using rosefire \(res!.user)")
            }
        }
        
        func signInWithGoogleCredential(_ credential: AuthCredential) {
            Auth.auth().signIn(with: credential) { res, err in
                
                if let err = err {
                    print("Error: \(err)")
                    return
                }
                
                print("Sign in completed \(res!.user)")
            }
        }
        
        func signOut() {
            do {
                try Auth.auth().signOut()
            } catch {
                print("Sign out failed: \(error)")
            }
        }
}
