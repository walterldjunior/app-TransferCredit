//
//  TedModel.swift
//  PagTed
//
//  Created by WalterJunior on 1/25/19.
//  Copyright © 2019 PagTeste. All rights reserved.
//

import Foundation

class TedModel: Codable {
	var codigo_banco: String
	var tipo_conta: String
	var agencia: Int
	var conta: Int
	var cpf_destino: String
	
	init(codigo_banco: String, tipo_conta: String, agencia: Int, conta: Int, cpf_destino: String ) {
		self.codigo_banco = codigo_banco
		self.tipo_conta = tipo_conta
		self.agencia = agencia
		self.conta = conta
		self.cpf_destino = cpf_destino
	}
}

