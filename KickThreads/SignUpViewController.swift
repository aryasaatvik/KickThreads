//
//  SignUpViewController.swift
//  KickThreads
//
//  Created by Saatvik Arya on 5/6/17.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

	@IBOutlet weak var name: UITextField!
	@IBOutlet weak var username: UITextField!
	@IBOutlet weak var email: UITextField!
	@IBOutlet weak var password: UITextField!
	@IBOutlet weak var repeatPassword: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func handleSignUp(_ sender: UIButton) {
		guard let nameInput = name.text, nameInput != "" else {
			print("Name is invalid")
			return
		}
		guard let usernameInput = username.text, usernameInput != "" else {
			print("Username is invalid")
			return
		}
		guard let emailInput = email.text, emailInput != "" else {
			print("Email is invalid")
			return
		}
		guard let passwordInput = password.text, let repeatPasswordInput = repeatPassword.text, passwordInput != "", repeatPasswordInput != "", passwordInput == repeatPasswordInput else {
			print("Password is invalid")
			return
		}
		
		FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text!) { user, error in
			if let error = error {
				print(error)
			} else {
				var ref: FIRDatabaseReference!
				ref = FIRDatabase.database().reference()
				ref.child("users/\(user!.uid)/name").setValue(self.name.text!)
				ref.child("users/\(user!.uid)/username").setValue(self.username.text!)
				ref.child("users/\(user!.uid)/email").setValue(self.email.text!)
				print("Account Created")
				if let tabViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController"){
					self.present(tabViewController, animated: true)
				}
			}
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
