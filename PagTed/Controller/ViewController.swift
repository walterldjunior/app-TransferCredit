//
//  ViewController.swift
//  PagTed
//
//  Created by WalterJunior on 1/21/19.
//  Copyright © 2019 PagTeste. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	//MARK:- Outlets
	@IBOutlet weak var accountBalanceLabel: UILabel!
	
	//MARK:- Variables
	var accountModel: AccountModel?
	
	//MARK:- View Manipulation
	override func viewDidLoad() {
		super.viewDidLoad()

		getAccountUser()
	}
	
	//MARK:- Functions
	func getAccountUser() {
		REST.loadAccount(onComplete: { (account) in
			
			self.accountModel = account
			self.initialDataScreen(value: self.accountModel?.correntista.saldo ?? 0)
		
		}) { (error) in
			switch error {
			case .url:
				print("Erro na URL")
			case .taskError( _):
				print("Erro na execução da task")
			case .noResponse:
				print("Erro no Response da request")
			case .responseStatusCode( _):
				print("Erro no StatusCode do servidor")
			}
		}
	}
	
	func initialDataScreen(value: Int) {
		DispatchQueue.main.async(execute: {
			self.accountBalanceLabel.text = "R$ \(String(describing: value)),00"
		})
	}
	
	//MARK:- Actions
	@IBAction func newTransferAction(_ sender: Any) {
		let controller = storyboard!.instantiateViewController(withIdentifier: "newTransferIdentity") as! NewTransferViewController
		controller.accountModel = accountModel
		self.present(controller, animated: true, completion: nil)
	}
	
}



