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
    
    @IBOutlet weak var heartButton: UIButton!
    var isLiked = false
    
    func addShadow(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 10, height: 10)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        self.view.addGestureRecognizer(tapRecognizer)
        
        addShadow(view: loginInput)
        addShadow(view: passwordInput)
        addShadow(view: loginButton)
        
        loginButton.layer.cornerRadius = 10
    }
    
    @objc func tapFunction() {
        self.view.endEditing(true)
    }

    @IBAction func pressedHeartButton(_ sender: Any) {
        guard let button = sender as? UIButton else {return}
        if isLiked {
            button.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        isLiked = !isLiked
    }
    
    
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
}

