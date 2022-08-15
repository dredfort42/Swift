//
//  APIController.swift
//  Day04
//
//  Created by Dmitry Novikov on 14.08.2022.
//

import Foundation

class APIController {

	weak var delegate: APITwitterDelegate?
	let token: String

	init(delegate:APITwitterDelegate?, token:String) {
		self.delegate = delegate
		self.token = token
	}

	private func prepareRequest(query: String) -> URLRequest {
		let urlSearch: String = "https://api.twitter.com/1.1/search/tweets.json?q="
		let urlQuery: String = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
		let urlParameters: String = "&count=100&result_type=recent&lang=en&tweet_mode=extended"
		let url = URL(string: urlSearch + urlQuery + urlParameters)
		var request = URLRequest(url: url!)

		request.httpMethod = "GET"
		request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

		return request
	}


	func getTweets(query: String) -> [Tweet] {
		let request = prepareRequest(query: query)
		var tweets: [Tweet] = []

		print("@@@@@@@getTweets")
		let tweetsData = URLSession.shared.dataTask(with: request) { (data, response, error) in
			if error != nil {
				print(error ?? "TWEETS REQUEST ERROR")
			} else if data != nil {
				do {
					if let dic:NSDictionary = try JSONSerialization.jsonObject(with: data!) as? NSDictionary {
						if let statuses: [NSDictionary] = dic.value(forKey: "statuses") as? [NSDictionary] {
							for tweet in statuses {
								let user: NSDictionary? = tweet["user"] as? NSDictionary
								let userName: String? = user?["name"] as? String
								let date: String? = tweet["created_at"] as? String
								let text:String? = tweet["full_text"] as? String
								tweets.append(Tweet(name: userName ?? "INCOGNITO", text: text ?? "NO_TEXT_ADDED"))

								print("@@@@@@@@@@@@@@@@@@@@@@")
								print(tweets.last ?? (Tweet(name: userName ?? "ERROR", text: text ?? "ERROR")))
								print(date ?? "ERROR")
								print("----------------------\n")
							}
						}
					}
				}
				catch (let error) {
					print(error)
				}
				print("@@@@@@@@@@ TOTAL TWEETS @@@@@@@@@@@@")
				print(tweets.count)
			}
		}

		tweetsData.resume()
		sleep(10)
		return tweets
	}
}
