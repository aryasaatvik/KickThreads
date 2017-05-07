//
//  InventoryViewController.swift
//  KickThreads
//
//  Created by Saatvik Arya on 5/6/17.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import UIKit
import Firebase

class InventoryViewController: UIViewController {

	@IBOutlet weak var inventoryLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		let userID = FIRAuth.auth()?.currentUser?.uid
		var ref: FIRDatabaseReference!
		ref = FIRDatabase.database().reference()
		ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { snapshot in
			let value = snapshot.value as? NSDictionary
			let name = value?["name"] as? String ?? ""
			self.inventoryLabel.text = "\(name)'s Inventory"
		}) { error in
			print(error.localizedDescription)
		}
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
