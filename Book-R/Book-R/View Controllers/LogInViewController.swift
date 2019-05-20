//
//  LogInViewController.swift
//  Book-R
//
//  Created by Hector Steven on 5/20/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	@IBAction func signInButton(_ sender: Any) {
		guard let username = usernameLabel.text,
			let password = passwordLabel.text else { return }
		
		
		print(username," - ", password)
		
	}
	
	@IBOutlet var singInButtonOutlet: UIButton!
	
	@IBOutlet var usernameLabel: UITextField!
	@IBOutlet var passwordLabel: UITextField!
}
