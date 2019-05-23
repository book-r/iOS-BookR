//
//  LogInViewController.swift
//  Book-R
//
//  Created by Hector Steven on 5/20/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit


enum LoginType {
	case signUp
	case signIn
}

class SignInSignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
    }
	
	fileprivate func logInErrorAlert(_ error: Error?) {
		if let error = error {
			print(error)
		}
		let alertController = UIAlertController(title: "Error", message: "Invalid password and/or username.\nPlease sign up.", preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
		self.present(alertController, animated: true)
	}
	
	
	
	@IBAction func signInButton(_ sender: Any) {
		guard let username = usernameLabel.text,
			let password = passwordLabel.text, !username.isEmpty , !password.isEmpty else {
	
			logInErrorAlert(nil)
			return
		}
		
		
		let user = User(username: username, password: password)
		
		if loginType == .signUp {
			apiController?.signUp(with: user, completion: { error in
				if let error = error {
					self.logInErrorAlert(error)
				}
			})
		} else {
			apiController?.signIn(with: user, completion: { error in
				if let error = error {
					self.logInErrorAlert(error)
				}
			})
			
		}
		
		self.dismiss(animated: true, completion: nil)
		print(username,"-", password)
	}
	
	@IBAction func segmentControlTapped(_ sender: UISegmentedControl) {
		
		if sender.selectedSegmentIndex == 0 {
			loginType = .signUp
			singInButtonOutlet.setTitle("Sign In", for: .normal)
		} else {
			loginType = .signUp
			singInButtonOutlet.setTitle("Sign Up", for: .normal)
		}
		
	}
	
	@IBOutlet var singInButtonOutlet: UIButton!
	
	@IBOutlet var usernameLabel: UITextField!
	@IBOutlet var passwordLabel: UITextField!
	@IBOutlet var segmentController: UISegmentedControl!
	
	var apiController: APIController? {didSet{print("set")}}
	
	var loginType: LoginType = .signIn
}
