//
//  AlertUtils.swift
//  PagTed
//
//  Created by WalterJunior on 2/1/19.
//  Copyright © 2019 PagTeste. All rights reserved.
//

import UIKit

open class AlertUtils {
	
	static func showAlert(_ controller: UIViewController, title: String, message: String) -> Bool {

		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		
		let okAction = UIAlertAction(title: "OK", style: .default, handler: { (_) -> Void in
			let c = controller.storyboard!.instantiateViewController(withIdentifier: "home")
			controller.show(c, sender: nil)
		})
		
		alertController.addAction(okAction)
		controller.present(alertController, animated: true, completion: nil)
		
		return false
	}
}
