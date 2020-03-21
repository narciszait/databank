//
//  GraphViewController.swift
//  Databank
//
//  Created by Narcis Zait on 20/03/2020.
//  Copyright (c) 2020 Narcis Zait. All rights reserved.
//

import UIKit
import Kingfisher

class GraphViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    private var presenter: GraphPresenterInput!
    
    class func instantiate(with presenter: GraphPresenterInput) -> GraphViewController {
        let name = "\(GraphViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! GraphViewController
        vc.presenter = presenter
        return vc
    }
    
    // MARK: - View Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewCreated()
        
        let value =  UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
        
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isMovingFromParent) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
    }
    
    @objc func canRotate() -> Void {}
    
    // MARK: - Callbacks -
    
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension GraphViewController: GraphPresenterOutput {
    func display(_ displayModel: Graph.DisplayData.Graph) {
        imageView.kf.setImage(with: displayModel.graphURL, options: [.transition(.fade(0.2))])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if self.imageView.image == nil {
                self.display(Graph.DisplayData.Error(message: "The call parameters for this table are not standard"))
            }
        }
    }
    
    func display(_ error: Graph.DisplayData.Error) {
        let alertController = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}
