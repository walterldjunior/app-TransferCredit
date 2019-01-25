//
//  BankListingViewController.swift
//  PagTed
//
//  Created by WalterJunior on 1/24/19.
//  Copyright © 2019 PagTeste. All rights reserved.
//

import UIKit

class BankListingViewController: UIViewController {

	//MARK:- Outlets
	@IBOutlet weak var bankTableView: UITableView!
	
	//MARK:- Variables
	var listBank: [BankModel] = []
	var selectedBank: BankModel?
	var funcCheck: ((_ value: BankModel)->Void)?
	
	//MARK:- View Manipulation
	override func viewDidLoad() {
        super.viewDidLoad()
		
		bankTableView.dataSource = self
		bankTableView.delegate = self
    }
	
	//MARK:- Functions
	func setDataScreen(_ value: [BankModel], funcCheck: @escaping ((_ value: BankModel)->Void)) {
		listBank = value
		
		self.funcCheck = funcCheck
	}
	
	func tapOrderNot(_ sender: Any) {
		guard let bank = selectedBank else {return}
		self.funcCheck?(bank)
	}

	
	//MARK:- Actions
	@IBAction func closedScreen(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
		
	}
}

//MARK:- UITableView Method
extension BankListingViewController: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return listBank.count
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
			tableView.cellForRow(at: indexPath)?.accessoryType = .none
		} else {
			tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
		}
	
		
		self.selectedBank = listBank[indexPath.row]
		guard let bank = selectedBank else {return}
		self.funcCheck?(bank)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier:"listiingBankCell", for: indexPath) as! BankTableViewCell
		
		cell.setScreen(listBank[indexPath.row])
		
		return cell
	}
}
