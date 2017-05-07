//
//  LogInViewController.swift
//  KickThreads
//
//  Created by Saatvik Arya on 5/6/17.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController, UITextViewDelegate {

	@IBOutlet weak var email: UITextField!
	@IBOutlet weak var password: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func handleLogIn(_ sender: UIButton) {
		guard let emailInput = email.text, emailInput != "" else {
			print("Email is invalid")
			return
		}
		guard let passwordInput = password.text, passwordInput != "" else {
			print("Password is invalid")
			return
		}
		FIRAuth.auth()?.signIn(withEmail: email.text!, password: password.text!) { user, error in
			if let error = error {
				print(error)
			} else {
				print("User Logged In")
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
