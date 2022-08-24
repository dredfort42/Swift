//
//  AuthenticationViewController.swift
//  Diary
//
//  Created by Dmitry Novikov on 22.08.2022.
//

import UIKit
import LocalAuthentication

class AuthenticationViewController: UIViewController {

	static var isLogin: Bool = false {
		didSet {
			print(isLogin)
		}
	}

	@IBOutlet weak var enterPasswordLabel: UILabel!
	@IBOutlet weak var enterPasswordField: UITextField!
	@IBOutlet weak var loginButtonView: UIButton!
	@IBAction func loginButtonAction(_ sender: UIButton) {
		checkPassword()
	}

	private let password = "dredfort"
	private let context = LAContext()
	private var error: NSError?

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		enterPasswordLabel.isHidden = true
		enterPasswordField.isHidden = true
		loginButtonView.isHidden = true

		autentication()
	}

	private func autentication() {
		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			let reason = NSLocalizedString("Identify yourself!", comment: "")

			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
				[weak self] success, authenticationError in

				DispatchQueue.main.async {
					if success {
						AuthenticationViewController.isLogin = true
						self?.goToDiary()
					} else {
						self?.enterPasswordLabel.isHidden = false
						self?.enterPasswordField.isHidden = false
						self?.loginButtonView.isHidden = false
						let error = NSLocalizedString("BIOMETRICS IDENTIFICATION ERROR", comment: "")
						print(error)
					}
				}
			}
		} else {
			enterPasswordLabel.isHidden = false
			enterPasswordField.isHidden = false
			loginButtonView.isHidden = false
			let error = NSLocalizedString("BIOMETRICS IDENTIFICATION NOT AVAILABLE", comment: "")
			print(error)
		}
	}

	private func checkPassword() {
		if password.isEqual(enterPasswordField.text) {
			enterPasswordLabel.text = ""
			goToDiary()
		} else {
			enterPasswordLabel.text = NSLocalizedString("Wrong password, please try again", comment: "")
			let error = NSLocalizedString("PASSWORD IDENTIFICATION ERROR", comment: "")
			print(error)
		}
	}

	private func goToDiary() {
		performSegue(withIdentifier: "goToDiary", sender: self)
		let success = NSLocalizedString("SUCCESS", comment: "")
		print(success)
	}

}

