//
//  InfoCollectionViewCell.swift
//  UniversalAppDemo
//
//  Created by Harsha on 21/04/2023.
//


import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.newsImageView.image = image
                    }
                }
            }
        }
    }
}
