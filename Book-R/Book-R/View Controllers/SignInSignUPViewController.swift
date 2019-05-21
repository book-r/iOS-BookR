//
//  LogInViewController.swift
//  Book-R
//
//  Created by Hector Steven on 5/20/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class SignInSignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
    }
	
	@IBAction func signInButton(_ sender: Any) {
		guard let username = usernameLabel.text,
			let password = passwordLabel.text,
			!username.isEmpty , !password.isEmpty else {
				
			//alert
				let alertController = UIAlertController(title: "Error", message: "Invalid password and/or username", preferredStyle: .alert)
				alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
				
				present(alertController, animated: true)
			return
		}
		
		
		print(username,"-", password)
		
		usernameLabel.text = nil
		passwordLabel.text = nil
	}
	
	@IBOutlet var singInButtonOutlet: UIButton!
	
	@IBOutlet var usernameLabel: UITextField!
	@IBOutlet var passwordLabel: UITextField!
	@IBOutlet var segmentController: UISegmentedControl!
}
