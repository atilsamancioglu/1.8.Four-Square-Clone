//
//  ViewController.swift
//  Foursquare Clone
//
//  Created by Atıl Samancıoğlu on 19/12/2016.
//  Copyright © 2016 Atıl Samancıoğlu. All rights reserved.
//

import UIKit
import Parse

class signInVC: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    
        
    }

    @IBAction func signInButtonClicked(_ sender: Any) {
        
        if usernameText.text != "" {
            if passwordText.text != "" {
                
                PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!, block: { (user, error) in
                    
                    if error != nil {
                        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                        alert.addAction(ok)
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        
                        UserDefaults.standard.set(user!.username, forKey: "userinfo")
                        UserDefaults.standard.synchronize()
                        
                        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                        delegate.rememberLogin()
                        
                    }
                    
                })
                
            }
        }
        
        
    }

    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        if usernameText.text != "" {
            if passwordText.text != "" {
                
                let user = PFUser()
                user.username = usernameText.text
                user.password = passwordText.text
                user.signUpInBackground(block: { (success, error) in
                    
                    if error != nil {
                        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                        alert.addAction(ok)
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        
                        UserDefaults.standard.set(user.username, forKey: "userinfo")
                        UserDefaults.standard.synchronize()
                        
                        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                        delegate.rememberLogin()
                        
                    }
                    
                })
                
            }
        }
        
    }

}

