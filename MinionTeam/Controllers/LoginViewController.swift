//
//  ViewController.swift
//  MinionTeam
//
//  Created by MacBook on 02.05.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet var firstLoadView: UIView!
    @IBOutlet var secondLoadView: UIView!
    @IBOutlet var thirdLoadView: UIView!
    
    // MARK: - Life Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        self.view.addGestureRecognizer(tapRecognizer)
        
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

    @IBAction func enterButton(_ sender: UIButton) {
    }
    
    // MARK: - Loading animation
    
    @IBAction func showLoadingAnimation(_ sender: UIButton) {
        
        self.firstLoadView.alpha = 0
        self.secondLoadView.alpha = 0
        self.thirdLoadView.alpha = 0
        
        let lifeTime = 1.0
        
        UIView.animate(withDuration: lifeTime, delay: 0, options: [.autoreverse, .repeat]) {
            self.firstLoadView.alpha = 1
        }
        UIView.animate(withDuration: lifeTime, delay: lifeTime / 3, options: [.autoreverse, .repeat]) {
            self.secondLoadView.alpha = 1
        }
        UIView.animate(withDuration: lifeTime, delay: lifeTime / 3 * 2, options: [.autoreverse, .repeat]) {
            self.thirdLoadView.alpha = 1
        }
        
    }
    
}

