//
//  settingsTableViewController.swift
//  Book-R
//
//  Created by Hector Steven on 5/21/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class settingsTableViewController: UITableViewController, APIControllerProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()

	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "settingsID", for: indexPath)
		cell.textLabel?.text = "log out"
		return cell
	}
	
	var apiController: APIController?
}
