//
//  ViewController.swift
//  appStoreRating
//
//  Created by Ebrahim  Mo Gedamy on 10/11/20.
//
/// https://medium.com/@abhimuralidharan/asking-customers-for-ratings-and-reviews-from-inside-the-app-in-ios-d85f256dd4ef


import UIKit
import StoreKit

class ViewController: UIViewController {

    
    private let button : UIButton = {
        let button = UIButton()
        button.setTitle("Rate us", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.addTarget(self, action: #selector(didBuTapped), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.center = view.center
        view.addSubview(button)
        
    }
    func rateApp(id : String) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/id\(id)?mt") else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @objc func didBuTapped (){
        /// request storekit to ask user for app rewiew
        let alert = UIAlertController(title: "Feedback", message: "Are you enjoying the app?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes, I love it!", style: .default, handler: {[weak self] _ in
            guard let self = self else{return}
            guard let scene = self.view.window?.windowScene else {
                print("no scene")
                return }
            SKStoreReviewController.requestReview(in: scene)
            self.rateApp(id: "id1147613120")
        }))
        alert.addAction(UIAlertAction(title: "No, This is sucks!", style: .default, handler: { (_) in
            
        }))
       present(alert, animated: true)
    }

}

