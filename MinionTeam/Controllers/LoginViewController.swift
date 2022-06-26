//
//  ViewController.swift
//  MinionTeam
//
//  Created by MacBook on 02.05.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var minionsImageView: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet var firstLoadView: UIView!
    @IBOutlet var secondLoadView: UIView!
    @IBOutlet var thirdLoadView: UIView!
    @IBOutlet var loadingView: UIView!
    
    // MARK: - Life Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        self.view.addGestureRecognizer(tapRecognizer)
        
        firstLoadView.alpha = 0
        secondLoadView.alpha = 0
        thirdLoadView.alpha = 0
        loadingView.isHidden = true
        
        loginButton.layer.cornerRadius = 10
         
    }
    
    @objc func tapFunction() {
        self.view.endEditing(true)
    }
      
    // MARK: - Segue

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let login = loginInput.text, let password = passwordInput.text else { return false }

        if login == "" && password == "" {
            return true
        } else {
            let alert = UIAlertController(title: "Error", message: "Wrong data", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)

            return false
        }
    }
    
  
    // MARK: - Loading animation
    
    @IBAction func logIn(_ sender: UIButton) {
        
        minionsImageView.isHidden = true
        loginLabel.isHidden = true
        loginInput.isHidden = true
        passwordLabel.isHidden = true
        passwordInput.isHidden = true
        loginButton.isHidden = true
        
        loadingView.isHidden = false
        showLoadingCircle()
            // self.performSegue(withIdentifier: "logInToVKSegue", sender: nil)
      //  self.performSegue(withIdentifier: "logInSegue", sender: nil)
        
    }

    func showLoadingCircle() {
        
        firstLoadView.alpha = 0
        secondLoadView.alpha = 0
        thirdLoadView.alpha = 0
        
        let lifeTime = 1.0
        
        UIView.animateKeyframes(withDuration: lifeTime, delay: 0, options: []) {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3) {
                self.firstLoadView.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
                self.firstLoadView.alpha = 0
            }
            UIView.addKeyframe(withRelativeStartTime: 1/6, relativeDuration: 1/3) {
                self.secondLoadView.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 1/3) {
                self.secondLoadView.alpha = 0
            }
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
                self.thirdLoadView.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
                self.thirdLoadView.alpha = 0
            }
            
        } completion: { _ in
            self.finishLoadingCircle()
        }
    }
    
    func finishLoadingCircle() {

        firstLoadView.alpha = 0
        secondLoadView.alpha = 0
        thirdLoadView.alpha = 0
        
        let lifeTime = 1.0
        
        UIView.animateKeyframes(withDuration: lifeTime, delay: 0, options: []) {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3) {
                self.firstLoadView.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
                self.firstLoadView.alpha = 0
            }
            UIView.addKeyframe(withRelativeStartTime: 1/6, relativeDuration: 1/3) {
                self.secondLoadView.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 1/3) {
                self.secondLoadView.alpha = 0
            }
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
                self.thirdLoadView.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
                self.thirdLoadView.alpha = 0
            }

        } completion: { _ in
           // self.showLoadingCircle()
            self.performSegue(withIdentifier: "logInSegue", sender: nil)
            //  self.performSegue(withIdentifier: "logInToVKSegue", sender: nil)

        }

    }
    
//    @IBAction func showLoadingAnimation(_ sender: UIButton) {
//
//        self.firstLoadView.alpha = 0
//        self.secondLoadView.alpha = 0
//        self.thirdLoadView.alpha = 0
//
//
//        let duration = 3.0
//        let lifeTime = duration / 3
//
//        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [.calculationModePaced, .autoreverse, .repeat]) {
//
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: lifeTime) {
//                self.firstLoadView.alpha = 1
//            }
//            UIView.addKeyframe(withRelativeStartTime: lifeTime, relativeDuration: lifeTime) {
//                self.firstLoadView.alpha = 0
//            }
//            UIView.addKeyframe(withRelativeStartTime: lifeTime / 3, relativeDuration: lifeTime) {
//                self.secondLoadView.alpha = 1
//            }
//            UIView.addKeyframe(withRelativeStartTime: lifeTime * 1.3, relativeDuration: lifeTime) {
//                self.secondLoadView.alpha = 0
//            }
//            UIView.addKeyframe(withRelativeStartTime: lifeTime / 3 * 2, relativeDuration: lifeTime) {
//                self.thirdLoadView.alpha = 1
//            }
//            UIView.addKeyframe(withRelativeStartTime: lifeTime / 5 * 2, relativeDuration: lifeTime) {
//                self.thirdLoadView.alpha = 0
//            }
//
//        } completion: { _ in
//
//        }
//
//
//    }
    
}

