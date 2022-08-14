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
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return Model.images.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellReuseId", for: indexPath) as! ImagesCollectionViewCell

		cell.indicatorView.startAnimating()
		cell.imageView.getImage(number: indexPath.row, cell: cell)
		cell.layer.borderWidth = 1
		cell.layer.borderColor = UIColor.lightGray.cgColor
		cell.layer.cornerRadius = 10

		return cell
	}
}

extension UIImageView {

	func getImage(number: Int, cell: ImagesCollectionViewCell) {
		guard var url = Model.errorUrl else {
			return
		}
		if number >= 0 && number < Model.images.count {
			guard let imgUrl = Model.images[number] else {
				return
			}
			url = imgUrl
		}
			DispatchQueue.global().async {
				var data = try? Data(contentsOf: url)
				if data == nil {
					data = try? Data(contentsOf: Model.errorUrl!)
				}
				if data != nil {
					DispatchQueue.main.async {
						cell.indicatorView.stopAnimating()
						cell.indicatorView.isHidden = true
						self.image = UIImage(data: data!)
					}
				}
			}
	}
}
