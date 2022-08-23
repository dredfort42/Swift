//
//  AddArticleViewController.swift
//  Diary
//
//  Created by Dmitry Novikov on 23.08.2022.
//

import UIKit
import dredfort2022

class AddArticleViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var contentTextView: UITextView!
	@IBOutlet weak var articleImageView: UIImageView!

	@IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
	}

	@IBAction func saveButtonAction(_ sender: UIBarButtonItem) {
		if titleTextField.text != nil
			&& articleImageView.image != nil {
			let manager = Articles.manager
			let newArticle = manager.newArticle()
			newArticle.title = titleTextField.text
			newArticle.image = (articleImageView.image?.jpegData(compressionQuality: 1.0))! as Data
			newArticle.content = contentTextView.text ?? ""
			newArticle.creationDate = Date()
			newArticle.modificationDate = newArticle.creationDate
			newArticle.language = Locale.preferredLanguages.first!
			manager.save()
			performSegue(withIdentifier: "backToDiary", sender: self)
		}
	}

	@IBAction func takePictureButtonAction(_ sender: UIButton) {
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			let imagePickerController = UIImagePickerController()
			imagePickerController.delegate = self
			imagePickerController.sourceType = .camera
			imagePickerController.allowsEditing = false
			self.present(imagePickerController, animated: true, completion: nil)
		}
	}

	@IBAction func choosePictureButtonAction(_ sender: UIButton) {
		if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
			let imagePickerController = UIImagePickerController()
			imagePickerController.delegate = self
			imagePickerController.sourceType = .photoLibrary
			imagePickerController.allowsEditing = false
			self.present(imagePickerController, animated: true, completion: nil)
		}
	}

	var article: Article?

	override func viewDidLoad() {
		super.viewDidLoad()

		guard let tmpArticle = article else {
			return
		}
		titleTextField.text = tmpArticle.title
		contentTextView.text = tmpArticle.content
		articleImageView.image = UIImage(data: tmpArticle.image! as Data)
	}

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		articleImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
		self.dismiss(animated: true, completion: nil)
	}

}
