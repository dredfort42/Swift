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

		cell.imageView.image = Model.getImage(number: indexPath.row)
		cell.layer.borderWidth = 1
		cell.layer.borderColor = UIColor.lightGray.cgColor
		cell.layer.cornerRadius = 10

		return cell
	}
}

