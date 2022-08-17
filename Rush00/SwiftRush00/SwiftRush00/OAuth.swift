//
//  OAuth.swift
//  SwiftRush00
//
//  Created by Dmitry Novikov on 16.08.2022.
//

import Foundation

struct APIToken: Decodable {
	let access_token: String?
}

class OAuth {
	private static let UID = "642d29fa06f1469a841b7342bb6ebec60262eeb24cdc292eada63af7fd17aec0"
	private static let SECRET = "4e7468d0979965004ecfea1beb875d5728cb114a933bfcda110817033a5912da"

	private static let STATE = String.getState()
	private static let authURL = "https://api.intra.42.fr/oauth/token"
	private static let grantType = "authorization_code"
	private static let redirectURI = "https://profile.intra.42.fr/success"
	static let signInURL = "https://signin.intra.42.fr"
	static var code: String = "" {
		didSet {
			isLogIn = !isLogIn
			getToken()
		}
	}
	static var token: String = "" {
		didSet {
			User.getUserInformation()
		}
	}
	static var isLogIn: Bool = false

	static func getLogInURLRequest() -> URLRequest {
		var generatedURL = URLComponents()
		generatedURL.scheme = "https";
		generatedURL.host = "api.intra.42.fr";
		generatedURL.path = "/oauth/authorize"
		generatedURL.queryItems = [
			URLQueryItem(name: "client_id", value: UID),
			URLQueryItem(name: "redirect_uri", value: redirectURI),
			URLQueryItem(name: "response_type", value: "code"),
			URLQueryItem(name: "scope", value: "public"),
			URLQueryItem(name: "state", value: STATE),
		]

		var request = URLRequest(url: generatedURL.url!)
		request.httpMethod = "GET"

		return request
	}

	 private static func getTokenURLRequest() -> URLRequest {
		var generatedURL = URLComponents()
		generatedURL.scheme = "https";
		generatedURL.host = "api.intra.42.fr";
		generatedURL.path = "/oauth/token"
		generatedURL.queryItems = [
			URLQueryItem(name: "grant_type", value: grantType),
			URLQueryItem(name: "client_id", value: UID),
			URLQueryItem(name: "client_secret", value: SECRET),
			URLQueryItem(name: "code", value: code),
			URLQueryItem(name: "redirect_uri", value: redirectURI),
			URLQueryItem(name: "state", value: STATE),
		]

		var request = URLRequest(url: generatedURL.url!)
		request.httpMethod = "POST"

		return request
	}

	private static func getToken() {
		let getData = URLSession.shared.dataTask(with: getTokenURLRequest()) {
			(data, response, error) in

			if error != nil {
				print("GET TOKEN ERROR")
			} else if data != nil {
				do {
					let result = try JSONDecoder().decode(APIToken.self, from: data!)
					guard let tryToken = result.access_token else {
						print("SET TOKEN ERROR")
						return
					}
					token = tryToken
					print("TOKEN: " + OAuth.token)
				} catch {
					print("TOKEN DECODING ERROR")
				}
			}
		}
		getData.resume()
	}


	static func getLogOutURLRequest() -> URLRequest {
		var generatedURL = URLComponents()
		generatedURL.scheme = "https";
		generatedURL.host = "signin.intra.42.fr";
		generatedURL.path = "/users/sign_out"
//		generatedURL.queryItems = [
//			URLQueryItem(name: "client_id", value: UID),
//			URLQueryItem(name: "redirect_uri", value: REDIRECT_URI),
//			URLQueryItem(name: "response_type", value: "code"),
//			URLQueryItem(name: "scope", value: "public"),
//			URLQueryItem(name: "state", value: STATE),
//		]

		var request = URLRequest(url: generatedURL.url!)
		request.httpMethod = "GET"

		return request
	}

}

extension String {

	static func getState(length: Int = 64) -> String {
		let base: String = "abcdefghijklmnopqrstuvwxyz0123456789"
		var randomString = String()

		for _ in 0..<length {
			let i = Int(arc4random_uniform(UInt32(base.count)))
			randomString.append(base[(base.index(base.startIndex, offsetBy: i))])
		}
		return randomString
	}
}
