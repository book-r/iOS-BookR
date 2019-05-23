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
	
	@IBAction func signInButton(_ sender: Any) {
		guard let username = usernameLabel.text,
			let password = passwordLabel.text, !username.isEmpty , !password.isEmpty else {
			//if error
			let alertController = UIAlertController(title: "Error", message: "Invalid password and/or username.\nPlease sign up.", preferredStyle: .alert)
			alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
			present(alertController, animated: true)
			return
		}
		
		//apiController?.createUser(username: username, password: password)
		let user = User(username: username, password: password)
		
		if loginType == .signUp {
			apiController?.signUp(with: user, completion: { error in
				if let error = error {
					print(error)
				} else {
					self.apiController?.setFavorites(user: user)
				}
			})
			
		} else {
		
			apiController?.signIn(with: user, completion: { error in
				if let error = error {
					print("Error Signig in \(error)")
				} else {
					self.apiController?.setFavorites(user: user)
				}
	
			})
			
		}
		
		print(username,"-", password)
		
		usernameLabel.text = nil
		passwordLabel.text = nil
		
		dismiss(animated: true, completion: nil)
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
