//
//  ViewController.swift
//  UniversalAppDemo
//
//  Created by Harsha on 18/04/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getNewsDetails()
        updateUI()
    }
    
    func updateUI() {
        self.title = "Books"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.lightGray
        collectionView.register(UINib(nibName: "InfoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "InfoCollectionViewCell")
    }
    
    func getNewsDetails() {
        viewModel.getNewsList { [weak self] isSuccess, response in
            if isSuccess {
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            } else {
                //show alert
            }
        }
    }
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : InfoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCollectionViewCell", for: indexPath) as! InfoCollectionViewCell
        cell.newsTitle.text = "Item cell.newsTitle.text = + String(indexPath.row)" + String(indexPath.row)
        cell.backgroundColor = UIColor.gray
        cell.newsTitle.textColor = UIColor.red
        return cell
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            let width = (collectionView.bounds.width / 4) - 15
            return CGSize(width: width, height: 150)
        } else {
            let width = (collectionView.bounds.width / 8) - 20
            return CGSize(width: width, height: 150)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 5.0)
    }
    
}
