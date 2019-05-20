//
//  SignUpViewController.swift
//  Book-R
//
//  Created by Hector Steven on 5/20/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
	@IBAction func signUpButton(_ sender: Any) {
		guard let username = usernameLabel.text,
			let password = passwordLabel.text,
			let retypePassword = reTypePasswordLabel.text else { return }
		
		
		print(username," - ", password, "-", retypePassword)
		
		usernameLabel.text = nil
		passwordLabel.text = nil
		reTypePasswordLabel.text = nil
		
		
	}
	@IBOutlet var signUpButtonOutlet: UIButton!
	
	@IBOutlet var usernameLabel: UITextField!
	@IBOutlet var passwordLabel: UITextField!
	@IBOutlet var reTypePasswordLabel: UITextField!
}
