//
//  TablesViewController.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright (c) 2020 Narcis Zait. All rights reserved.
//

import UIKit

class TablesViewController: UIViewController {

    private var presenter: TablesPresenterInput!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: "TablesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "tablesCell")
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    

    class func instantiate(with presenter: TablesPresenterInput) -> TablesViewController {
        let name = "\(TablesViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! TablesViewController
        vc.presenter = presenter
        return vc
    }

    // MARK: - View Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewCreated()
        
//        navigationItem.title = presenter.navTitle
//        navigationController?.navigationBar.prefersLargeTitles = true
//        adjustLargeTitleSize()
        
        setupNavTitle()
    }
    
    func setupNavTitle() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        titleLabel.text = presenter.navTitle
        titleLabel.textColor = UIColor.label
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.minimumScaleFactor = 0.2
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        navigationItem.titleView = titleLabel
    }

    // MARK: - Callbacks -

}

extension TablesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tablesCell", for: indexPath) as! TablesCollectionViewCell
        
        presenter.configure(item: cell, at: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.handle(action: .itemSelected(row: indexPath.row))
    }
}

extension TablesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 1

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size / 2)
    }
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension TablesViewController: TablesPresenterOutput {
    func display(_ displayModel: Tables.DisplayData.Tables) {
        collectionView.reloadData()
    }
    
    func display(_ error: Tables.DisplayData.Error) {
        let alertController = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    

}
