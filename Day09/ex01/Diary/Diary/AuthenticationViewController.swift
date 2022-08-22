//
//  AuthenticationViewController.swift
//  Diary
//
//  Created by Dmitry Novikov on 22.08.2022.
//

import UIKit
import LocalAuthentication

class AuthenticationViewController: UIViewController {

	let context = LAContext()
	var error: NSError?

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		autentication()
	}

	func autentication() {
		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			let reason = "Identify yourself!"

			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
				[weak self] success, authenticationError in

				DispatchQueue.main.async {
					if success {
						self?.unlockSecretMessage()
					} else {
						self?.autentication()
						print("IDENTIFICATION ERROR")
					}
				}
			}
		} else {
			print("BIOMETRICS IDENTIFICATION NOT AVAILABLE")
		}
	}

	func unlockSecretMessage() {
		print("SUCCESS")
	}

}

