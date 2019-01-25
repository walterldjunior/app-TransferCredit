//
//  BankTableViewCell.swift
//  PagTed
//
//  Created by WalterJunior on 1/24/19.
//  Copyright © 2019 PagTeste. All rights reserved.
//

import UIKit

class BankTableViewCell: UITableViewCell {
	
	//MARK:- Oulets
	@IBOutlet weak var nameBank: UILabel!
	@IBOutlet weak var numberBank: UILabel!
	
	//MARK:- View Manipulation
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	//MARK:- Functions
	func setScreen(_ value: BankModel){
		nameBank.text = value.NOME
		numberBank.text = String(value.CODIGO_BANCO)
	}
}
