//
//  BankModel.swift
//  PagTed
//
//  Created by WalterJunior on 1/22/19.
//  Copyright © 2019 PagTeste. All rights reserved.
//

import Foundation

class BankModel: Codable {
	var CODIGO_BANCO: Int
	var NOME: String
}

class ResultBankModel: Codable {
	var DADOS: ListResultBank
}

class ListResultBank: Codable {
	var BANCO: [BankModel]
}

