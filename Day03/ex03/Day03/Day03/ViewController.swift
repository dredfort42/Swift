//
//  ViewController.swift
//  Day03
//
//  Created by Dmitry Novikov on 14.08.2022.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var imagesCollectionView: UICollectionView!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		self.imagesCollectionView.dataSource = self
		self.imagesCollectionView.delegate = self
	}

	func sendAlert(url: URL) {
		let alert = UIAlertController(
			title: "Error",
			message: "Cannot acces to \(url)",
			preferredStyle: UIAlertController.Style.alert)

		alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destination = segue.destination as! DetailedViewController
		let cell = sender! as! ImagesCollectionViewCell

		destination.detailedImageView = UIImageView(image: cell.imageView.image)
	}

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return Model.images.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellReuseId", for: indexPath) as! ImagesCollectionViewCell

		cell.indicatorView.startAnimating()
		if indexPath.row >= 0 && indexPath.row < Model.images.count {
			let url = Model.images[indexPath.row]

			DispatchQueue.global().async {
				var data = try? Data(contentsOf: url!)
				var urlError = false
				
				if data == nil {
					data = try? Data(contentsOf: Model.errorUrl!)
					urlError = true
				}
				if data != nil {
					DispatchQueue.main.async {
						if urlError {
							self.sendAlert(url: url!)
						}
						cell.indicatorView.stopAnimating()
						cell.indicatorView.isHidden = true
						cell.imageView.image = UIImage(data: data!)
					}
				}
			}
		}
		cell.layer.borderWidth = 1
		cell.layer.borderColor = UIColor.lightGray.cgColor
		cell.layer.cornerRadius = 10

		return cell
	}
}
