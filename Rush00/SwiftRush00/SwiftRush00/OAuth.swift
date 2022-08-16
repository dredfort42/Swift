//
//  OAuth.swift
//  SwiftRush00
//
//  Created by Dmitry Novikov on 16.08.2022.
//

import Foundation

class OAuth {
	private let UID: String = "642d29fa06f1469a841b7342bb6ebec60262eeb24cdc292eada63af7fd17aec0"
	private let SECRET: String = "4e7468d0979965004ecfea1beb875d5728cb114a933bfcda110817033a5912da"
	private let REDIRECT_URI: String = "https://profile.intra.42.fr"
	private let STATE: String = String.random(length: 16)
	static var token: String?

	func getOAuchURL() -> URLRequest {
		var generatedURL = URLComponents()
		generatedURL.scheme = "https";
		generatedURL.host = "api.intra.42.fr";
		generatedURL.path = "/oauth/authorize"
		generatedURL.queryItems = [
			URLQueryItem(name: "client_id", value: UID),
			URLQueryItem(name: "redirect_uri", value: REDIRECT_URI),
			URLQueryItem(name: "response_type", value: "code"),
			URLQueryItem(name: "scope", value: "public"),
			URLQueryItem(name: "state", value: STATE),
		]

		return URLRequest(url: generatedURL.url!)
	}

	func getToken(code: String) {
		var generatedURL = URLComponents()
		generatedURL.scheme = "https";
		generatedURL.host = "api.intra.42.fr";
		generatedURL.path = "/oauth/token"
		generatedURL.queryItems = [
			URLQueryItem(name: "grant_type", value: "authorization_code"),
			URLQueryItem(name: "client_id", value: UID),
			URLQueryItem(name: "client_secret", value: SECRET),
			URLQueryItem(name: "code", value: code),
			URLQueryItem(name: "redirect_uri", value: REDIRECT_URI),
			URLQueryItem(name: "state", value: STATE),
		]

		var request = URLRequest(url: generatedURL.url!)
		request.httpMethod = "POST"

		let getData = URLSession.shared.dataTask(with: request) { (data, response, error) in
			if error != nil {
				print("GET TOKEN ERROR")
			} else if data != nil {
				do {
					if let dic: NSDictionary = try JSONSerialization.jsonObject(with: data!) as? NSDictionary {
						OAuth.token = dic.value(forKey: "access_token") as? String
				   }
				}
				catch {
					print("TOKEN DECODING ERROR")
				}
			}
		}
		getData.resume()
		sleep(1)

		print("TOKEN: " + (OAuth.token ?? "NIL"))
	}
}

extension String {

	static func random(length: Int) -> String {
		let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		var randomString: String = ""

		for _ in 0..<length {
			let randomValue = arc4random_uniform(UInt32(base.count))
			randomString += "\(base.index(base.startIndex, offsetBy: Int(randomValue)))"
		}
		return randomString
	}
}
