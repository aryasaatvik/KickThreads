//
//  InventoryViewController.swift
//  KickThreads
//
//  Created by Saatvik Arya on 5/5/17.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import UIKit
import Firebase
import VisualRecognitionV3

class ScanViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var status: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		let apiKey = "f72043002500cb482b97ab6e20317d49b2460b24"
		let version = "2017-05-04"
		let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
		
		let image = info[UIImagePickerControllerOriginalImage] as! UIImage
		let jpg = UIImageJPEGRepresentation(image, 0.5)
		let imageRef = FIRStorage.storage().reference().child("images/sneaker.jpg")
		let uploadTask = imageRef.put(jpg!, metadata: nil) { metadata, error in
			if let error = error {
				print(error)
			} else {
				let downloadURL = metadata!.downloadURL()?.absoluteURL
				let failure = { (error: Error) in print(error) }
				visualRecognition.classify(imageFile: downloadURL!, failure: failure) { classifiedImages in
					self.status.text = "Done"
					print(classifiedImages)
					print(downloadURL!)
				}
			}
		
		}
		uploadTask.observe(.progress) { snapshot in
			print("progress")
			let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
			print(percentComplete)
		}
		uploadTask.observe(.success) { snapshot in
			print("success")
		}
		uploadTask.observe(.failure) { snapshot in
			print("failure")
			if let error = snapshot.error {
				print(error)
			}
		}
		imageView.image = image
		dismiss(animated: true, completion: nil)
	}

	@IBAction func handleSelectPhoto(_ sender: UIButton) {
		let imagePicker = UIImagePickerController()
		
		if UIImagePickerController.isSourceTypeAvailable(.camera){
			imagePicker.sourceType = .camera
		}
		else {
			imagePicker.sourceType = .photoLibrary
		}
		
		imagePicker.delegate = self
		
		present(imagePicker, animated: true, completion: nil)
	}
}

