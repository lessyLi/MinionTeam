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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

