//
//  ViewController.swift
//  dredfort2022
//
//  Created by 102029973 on 08/21/2022.
//  Copyright (c) 2022 102029973. All rights reserved.
//

import UIKit
import dredfort2022

class ViewController: UIViewController {

	let articleManager = ArticleManager()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		print("ARTICLES COUNT: \(articleManager.getAllArticles().count)")

		var article = articleManager.newArticle()

		article.title = "My article\(articleManager.getAllArticles().count + 1)"
		article.language = "en"
		article.content = "Content of article\(articleManager.getAllArticles().count + 1). TEST. 42 Piscine iOS Swift - Day 08 pod dredfort2022 is a part of article manager"
		article.creationDate = Date()
		article.modificationDate = Date()
		print("\n\nNEW ARTICLE ##########")
		print(article.description)

		article = articleManager.newArticle()
		article.title = "Новая статья\(articleManager.getAllArticles().count + 1)"
		article.language = "ru"
		article.content = "Содержание статьи\(articleManager.getAllArticles().count + 1). TEST. 42 Piscine iOS Swift - Day 08 pod dredfort2022 is a part of article manager"
		article.creationDate = Date()
		article.modificationDate = Date()

		print("\n\nNEW ARTICLE ##########")
		print(article.description)

		print("\n\nSAVE ##########")
		articleManager.save()

		print("\n\nALL ARTICLES ##########")
		print(articleManager.getAllArticles())

		print("\n\nALL ARTICLES IN RUSSIN ##########")
		print(articleManager.getArticles(withLang : "ru"))

		print("\n\nALL ARTICLES CONTAINING Новая ##########")
		print(articleManager.getArticles(containString : "Новая"))

		print("\n\nALL REMOVE TWO LAST ARTICLES ##########")
		print("ARTICLES COUNT: \(articleManager.getAllArticles().count)")
		articleManager.removeArticle(article: articleManager.getAllArticles().last!)
		articleManager.removeArticle(article: articleManager.getAllArticles().last!)
		print("ARTICLES COUNT: \(articleManager.getAllArticles().count)")

	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

