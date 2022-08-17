//
//  ViewController.swift
//  SwiftRush00
//
//  Created by Dmitry Novikov on 16.08.2022.
//

import UIKit
import WebKit

class AuthorizationView: UIViewController, WKNavigationDelegate {

	@IBOutlet weak var webAutorizationView: WKWebView! {
		didSet {
			webAutorizationView.navigationDelegate = self
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		if !OAuth.isLogIn {
			OAuth.code = ""
			OAuth.token = ""
			webAutorizationView.load(OAuth.getLogOutURLRequest())
		}
		webAutorizationView.load(OAuth.getLogInURLRequest())
	}

	func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
		guard let response = webView.url else {
			return
		}
		if response.absoluteString.contains(OAuth.signInURL) == false {
			if let code = URLComponents(string: response.absoluteString)?.queryItems?.first?.value  {
				webView.stopLoading()
				OAuth.code = code
				print("CODE: " + OAuth.code)

				performSegue(withIdentifier: "showMainView", sender: self)
			}
		}
	}

}

