//
//  NewTransferViewController.swift
//  PagTed
//
//  Created by WalterJunior on 1/22/19.
//  Copyright © 2019 PagTeste. All rights reserved.
//

import UIKit

class NewTransferViewController: UIViewController {
	
	//MARK:- Outltes
	@IBOutlet weak var nameBank: UILabel!
	@IBOutlet weak var valueByTed: UITextField!
	
	//MARK:- Variables
	var listBank: [BankModel] = []
	var bank: BankModel?
	var accountModel: AccountModel?
	var showAlert: Bool = false
	
	//MARK:- View Manipulation
    override func viewDidLoad() {
        super.viewDidLoad()

		getListBank()
		
		valueByTed.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
    }
	
	//MARK:- Functions
	func getListBank() {
		REST.loadBank(onComplete: { (listBankAll) in
			self.listBank = listBankAll
		})
	}
	
	func saveTed(_ value: TedModel) {
		REST.saveTed(ted: value) { (success) in
			print("TED salvo")
		}
	}

	func addvalueLabelBank(value: BankModel) {
		bank = value
		nameBank.text = bank!.NOME
	}
	
	func verifyConfirmTed() {
		guard let numberBank = bank?.CODIGO_BANCO else {return}
		
		let ted = TedModel(codigo_banco: "\(String(describing: numberBank))", tipo_conta: "CONTA_CORRENTE", agencia: 1234, conta: 34329-7, cpf_destino: "92349157040")
	
		
		guard let valueInput = valueByTed.text?.currencyInputFormatting() else { return }
		guard let balanceUser = accountModel?.correntista.saldo else { return }
		
		if Int(valueInput) ?? 0 < balanceUser {
			
			saveTed(ted)
			_ = AlertUtils.showAlert(self, title: "Tudo certo!",message: "Transferência realizada com Sucesso")
		} else {
			_ = AlertUtils.showAlert(self, title: "Temos um problema!",message: "Ops, ocorreu um erro na realização da sua Transferência")
		}
	}

	@objc func myTextFieldDidChange(_ textField: UITextField) {
		if let amountString = textField.text?.currencyInputFormatting() {
			textField.text = amountString
		}
	}
	
	//MARK:- Actions
	@IBAction func openScreenBankSelect(_ sender: Any) {
		let controller = storyboard!.instantiateViewController(withIdentifier: "banklisting") as! BankListingViewController
		controller.setDataScreen(listBank, funcCheck: self.addvalueLabelBank )
		self.present(controller, animated: true, completion: nil)
	}
	
	@IBAction func confirmTed(_ sender: Any) {
		verifyConfirmTed()
	}
	
	@IBAction func closedScreen(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
}

//MARK:- Extension String
extension String {
	func currencyInputFormatting() -> String {
		
		var number: NSNumber!
		let formatter = NumberFormatter()
		formatter.locale = NSLocale(localeIdentifier: "pt_BR") as Locale
		formatter.numberStyle = .currencyAccounting
		formatter.maximumFractionDigits = 2
		formatter.minimumFractionDigits = 2
		
		var amountWithPrefix = self
		
		let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
		amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
		
		let double = (amountWithPrefix as NSString).doubleValue
		number = NSNumber(value: (double / 100))
		
		guard number != 0 as NSNumber else {
			return ""
		}
		return formatter.string(from: number)!
	}
}
