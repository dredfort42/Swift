//
//  User.swift
//  SwiftRush00
//
//  Created by Dmitry Novikov on 16.08.2022.
//

import Foundation
import UIKit

struct APIUser: Decodable {
	let login: String?
	let last_name: String?
	let first_name: String?
	let image_url: String?
}

class User {
	static var surname: String = ""
	static var name: String = ""
	static var login: String = ""
	static var picture: String = ""
	static var level: String = ""

	private static func getUserDataURLRequest() -> URLRequest {
		var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/me")!)
		request.httpMethod = "GET"
		request.setValue("Bearer " + OAuth.token, forHTTPHeaderField: "Authorization")

		return request
	}

	static func getUserInformation() {
		let getData = URLSession.shared.dataTask(with: getUserDataURLRequest()) {
			(data, response, error) in
			if error != nil {
				print("GET USER INFORMATION ERROR")
			} else if data != nil {
				do {
					let result = try JSONDecoder().decode(APIUser.self, from: data!)
					print(result)
					guard let tryLogin = result.login else {
						print("SET LOGIN ERROR")
						return
					}
					login = tryLogin
					guard let tryName = result.first_name else {
						print("SET NAME ERROR")
						return
					}
					name = tryName
					guard let trySurname = result.last_name else {
						print("SET SURNAME ERROR")
						return
					}
					surname = trySurname
					if result.image_url != nil {
						picture = result.image_url!
					} else {
						picture = "https://avatars.githubusercontent.com/u/102029973"
					}


					if let dic:NSDictionary = try JSONSerialization.jsonObject(with: data!) as? NSDictionary {
						if let cursus_users: [NSDictionary] = dic.value(forKey: "cursus_users") as? [NSDictionary] {
							guard let tryLevel = cursus_users[1].value(forKey: "level") else {
								print("SET LEVEL ERROR")
								return
							}
							level = String(describing: tryLevel)
						}
					}

				} catch {
					print("USER INFORMATION DECODING ERROR")
				}
			}
		}
		getData.resume()
	}
}
