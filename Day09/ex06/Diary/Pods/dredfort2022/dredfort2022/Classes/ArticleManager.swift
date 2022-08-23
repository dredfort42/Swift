//
//  ArticleManager.swift
//  dredfort2022
//
//  Created by Dmitry Novikov on 22.08.2022.
//

import Foundation
import CoreData

public class ArticleManager: NSObject {

	public override init() {
		super.init()
	}

	private lazy var managedObjectContext: NSManagedObjectContext = {
		let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
		managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator

		return managedObjectContext
	}()

	private var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
		guard let modelURL = Bundle(for: dredfort2022.Article.self).url(
			forResource: "article",
			withExtension:"momd"
		) else {
			fatalError("Error loading model from bundle")
		}
		guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
			fatalError("Error initializing mom from: \(modelURL)")
		}
		let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
		guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
			fatalError("Unable to resolve document directory")
		}
		let storeURL = docURL.appendingPathComponent("ArticleManager.sqlite")
		do {
			try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
		} catch {
			fatalError("Error migrating store: \(error)")
		}
		return psc
	}()

	public func newArticle() -> Article {
		return NSEntityDescription.insertNewObject(forEntityName: "Article", into: managedObjectContext) as! Article
	}

	public func getAllArticles() -> [Article] {
		let articles = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
		do {
			return try (managedObjectContext.fetch(articles) as? [Article])!
		} catch {
			return []
		}
	}

	public func getArticles(withLang lang: String) -> [Article] {
		let articles = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
		articles.predicate = NSPredicate(format: "language == %@", lang)
		do {
			return try (managedObjectContext.fetch(articles) as? [Article])!
		} catch {
			return []
		}
	}

	public func getArticles(containString str: String) -> [Article] {
		let articles = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
		articles.predicate = NSPredicate(format: "title CONTAINS %@ || content CONTAINS %@", str, str)
		do {
			return try (managedObjectContext.fetch(articles) as? [Article])!
		} catch {
			return []
		}
	}

	public func removeArticle(article: Article) {
		managedObjectContext.delete(article)
	}

	public func save() {
		do {
			try managedObjectContext.save()
		} catch {
			print("SAVE ARTICLE ERROR")
		}
	}
}
