//
//  OAuch2.swift
//  Day04
//
//  Created by Dmitry Novikov on 15.08.2022.
//

import Foundation

struct OAuch2 {
	private let apiKey = "TQrY2wPa1nJS4A15f78q5Q0Q8"
	private let apiSecret = "4TekrHmLJ71uVcm2GIHIoyhKgdXGtkrphNGn536Zl1wTrtDoqR"
	private let apiBearer: String

	init() {
		apiBearer = (apiKey + ":" + apiSecret)
			.data(using: String.Encoding.utf8)!
			.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
	}

	private func prepareOAuchRequest() -> URLRequest {
		let url = URL(string: "https://api.twitter.com/oauth2/token")
		var request = URLRequest(url: url!)

		request.httpMethod = "POST"
		request.setValue("Basic \(apiBearer)", forHTTPHeaderField: "Authorization")
		request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
		request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)

		return request
	}

	private func sendOAuchRequest(request: URLRequest) -> String? {
		var token: String?

		let auchRequest = URLSession.shared.dataTask(with: request) { (data, response, error) in
			if error != nil {
				print(error ?? "OAUCH REQUEST ERROR")
			} else if data != nil {
				do {
					if let dic: NSDictionary = try JSONSerialization.jsonObject(with: data!) as? NSDictionary {
						token = dic.value(forKey: "access_token") as? String
					}
				}
				catch (let error) {
					print(error)
				}
			}
		}
		auchRequest.resume()
		sleep(1)

		return token
	}

	func getToken() -> String {
		let request: URLRequest = prepareOAuchRequest()
		var token: String?
		var retry: Int = 0

		while token == nil || retry > 10 {
			token = sendOAuchRequest(request: request)
			retry += 1
		}

		return token ?? "TokenWasNotReceived"
	}
}
