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
		webAutorizationView.load(OAuth().getOAuchURL())
	}

	func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {

		let isSignInURL: Bool? = webView.url?.absoluteString.contains("https://signin.intra.42.fr")

//		let isSignInPage = responseURL.absoluteString.contains(signInURL)
//
		if isSignInURL == false {
			let code = URLComponents(string: (webView.url?.absoluteString) ?? "")?.queryItems?[0].value

			if code != nil {
				print("CODE: " + code!)
				OAuth().getToken(code: code!)
			}

//			guard let urlComp = URLComponents(string:responseURL.absoluteString) else {
//				manageError("Something went wrong")
//				return
//			}
//
//			if let code = urlComp.queryItems?.first(where: { $0.name == "code" })?.value  {
//				webView.stopLoading()
//				self.code = code
//				self.exchangeCodeForToken()
//			}
//
//			if (urlComp.queryItems?.first(where: { $0.name == "error" })?.value) != nil  {
//				webView.stopLoading()
//			   self.manageError("Access denied")
//			}
			webView.stopLoading()
		}

	}

}

