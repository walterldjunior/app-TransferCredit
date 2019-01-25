//
//  REST.swift
//  PagTed
//
//  Created by WalterJunior on 1/22/19.
//  Copyright © 2019 PagTeste. All rights reserved.
//

import Foundation

enum AccountError {
	case url
	case taskError(error: Error)
	case noResponse
	case responseStatusCode(code: Int)
}

class REST {
	
	//MARK:- Contexto de Session
	// URLSession.shared.dataTask
	private static let configuration: URLSessionConfiguration = {
		let config = URLSessionConfiguration.default
		config.httpAdditionalHeaders = ["Content-Type": "application/json"]
		config.timeoutIntervalForRequest = 30.0
		
		return config
	}()
	
	private static let session = URLSession(configuration: configuration)
	
	//MARK:- Contexto de Get Conta
	private static let basePathGET = "http://demo9660994.mockable.io"
	private static let getBalanceAccount = "/getSaldoConta"
	
	//MARK:- Contexto de Get Banco
	private static let basePathListBank = "https://mobile.meupag.com.br"
	private static let getLisBank = "/mobile/ted/listarBancos"
	
	//MARK:- Contexto de Post Banco
	private static let basePathBank = "http://www.mocky.io"
	private static let postTed = "/v2/5c40e6d10f00003414e7b6c4"
	
	//MARK:- Load Account
	class func loadAccount(onComplete: @escaping (AccountModel) -> Void, onError: @escaping (AccountError) -> Void) {
		guard let url = URL(string: basePathGET + getBalanceAccount) else {
			onError(.url)
			return
		}
		
		let dataTask = session.dataTask(with: url) { (data, response, error) in
			if error == nil {
				
				guard let response = response as? HTTPURLResponse else {return}
				if response.statusCode == 200 {
					guard let data = data else {return}
					do {
					let account = try JSONDecoder().decode(AccountModel.self, from: data)
						onComplete(account)
					} catch {
						print(error.localizedDescription)
					}
					
				} else {
					print("Algum status inválido pelo servidor!!")
				}
			} else {
				onError(.taskError(error: error!))
			}
		}
		dataTask.resume()
	}
	
	//MARK:- Load Bank
	class func loadBank(onComplete: @escaping ([BankModel]) -> Void) {
		guard let url = URL(string: basePathListBank + getLisBank) else { return }
		let jsonBody = "{}"
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.httpBody = jsonBody.data(using: String.Encoding.utf8)
		
		let dataTask = session.dataTask(with: request) { (data, response, error) in
			if error == nil {
				guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else { return }
				do {
					let result = try JSONDecoder().decode(ResultBankModel.self, from: data)
					let listBankAll = result.DADOS.BANCO
					onComplete(listBankAll)
				} catch {
					print(error.localizedDescription)
				}
			}
		}
		dataTask.resume()
	}
	
	//MARK:- Post Ted
	class func saveTed(ted: TedModel, onComplete: @escaping (Bool) -> Void) {
		guard let url = URL(string: basePathBank + postTed) else { return }
	
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		
		guard let jsonTed = try? JSONEncoder().encode(ted) else {
			onComplete(false)
			return
		}
		request.httpBody = jsonTed
		
		let dataTask = session.dataTask(with: request) { (data, response, error) in
			if error == nil {
				guard let response = response as? HTTPURLResponse, response.statusCode == 200, let _ = data else {
					onComplete(false)
					return
				}
				onComplete(true)
			}
			else {
				onComplete(false)
			}
		}
		dataTask.resume()
	}
}
