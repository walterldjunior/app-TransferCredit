//
//  AccountModel.swift
//  PagTed
//
//  Created by WalterJunior on 1/21/19.
//  Copyright © 2019 PagTeste. All rights reserved.
//

import Foundation

class AccountModel: Codable {
	var correntista: AccountAttributes
}

class AccountAttributes: Codable {
	var saldo: Int
}

