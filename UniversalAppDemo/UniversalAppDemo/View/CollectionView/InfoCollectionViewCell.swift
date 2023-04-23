//
//  InfoCollectionViewCell.swift
//  UniversalAppDemo
//
//  Created by Harsha on 21/04/2023.
//


import UIKit
import SDWebImage

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
        newsImageView.image = UIImage.init(systemName: "photo")
        DispatchQueue.global(qos: .background).async {
            self.newsImageView.sd_setImage(with: url, placeholderImage: UIImage.init(systemName: "photo"), options: .waitStoreCache) { (_, _, _, _) in
                // Do any UI updates on the main thread
                DispatchQueue.main.async {
                    self.setNeedsLayout()
                }
                
            }
        }
    }
}
