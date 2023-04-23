//
//  ViewController.swift
//  UniversalAppDemo
//
//  Created by Harsha on 18/04/2023.
//

import UIKit
import CoreData
import Reachability

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = SearchViewModel()
    var fetchedResultsController: NSFetchedResultsController<News>?
    let activityView = UIActivityIndicatorView(style: .large)
    var refresher = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController = viewModel.getResult()
        updateUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        if UIDevice.current.userInterfaceIdiom == .phone {
            let width = (collectionView.bounds.width / 4) - 15
            flowLayout.itemSize = CGSize(width: width, height: 150)
        } else {
            let width = (collectionView.bounds.width / 8) - 20
            flowLayout.itemSize = CGSize(width: width, height: 150)
        }
        flowLayout.invalidateLayout()
    }
    
    func updateUI() {
        self.title = "World News"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.lightGray
        collectionView.alwaysBounceVertical = true
        collectionView.register(UINib(nibName: "InfoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "InfoCollectionViewCell")
        refresher.tintColor = UIColor.red
        refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        collectionView.addSubview(refresher)
        
        let errorLabel = UILabel.init(frame: CGRect.init(origin: CGPoint.init(x: 0.0, y: self.view.frame.midY), size: CGSize.init(width: self.view.frame.width, height: 44.0)))
        errorLabel.textAlignment = .center
        if ReachabilityManager.manager.isConnected() {
            getNewsDetails()
        } else {
            if !((fetchedResultsController?.fetchedObjects?.count ?? 0) > 0) {
                errorLabel.text = "Please check internet, Pull to refresh..!"
                self.view.addSubview(errorLabel)
            }
        }
        addActivityIndicatory()
    }
    
    @objc func loadData() {
        refresher.beginRefreshing()
        getNewsDetails()
    }
    
    func getNewsDetails() {
        self.activityView.startAnimating()
        viewModel.getNewsList { [weak self] isSuccess, response in
            if isSuccess {
                DispatchQueue.main.async {
                    self?.activityView.stopAnimating()
                    self?.fetchedResultsController = self?.viewModel.getResult()
                    self?.refresher.endRefreshing()
                    self?.collectionView.reloadData()
                }
            } else {
                ToastView(message: "Error loading news").show()
            }
        }
    }
    
    func addActivityIndicatory() {
        activityView.center = self.view.center
        self.view.addSubview(activityView)
    }
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController?.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : InfoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCollectionViewCell", for: indexPath) as! InfoCollectionViewCell
        let news = fetchedResultsController?.object(at: indexPath)
        cell.newsTitle.text = news?.title
        if let imageurl = URL(string: news?.imageUrl ?? "") {
            cell.loadImage(url: imageurl)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if ReachabilityManager.manager.isConnected() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "NewsDetailsViewController") as? NewsDetailsViewController {
                if var readMoreurl = fetchedResultsController?.object(at: indexPath).readMoreUrl {
                    readMoreurl = readMoreurl.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    vc.newsURL = readMoreurl
                    self.present(vc, animated: true)
                }
            }
        } else {
            ToastView(message: "Error loading news, check internet").show()
        }
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
        return UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    }
    
}
