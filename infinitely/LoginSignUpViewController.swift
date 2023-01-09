//
//  loginSignUpViewController.swift
//  infinitely
//
//  Created by Riccardo Petrucci on 09/01/23.
//

import UIKit
import Firebase

class LoginSignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginSignUpBtn: UIButton!
    
    override func viewDidLoad() {
        setupLoginSignUpBtn()
    }
    
    func setupLoginSignUpBtn() {
        loginSignUpBtn.setTitle("Enter", for: .normal)
        loginSignUpBtn.setTitleColor(.white, for: .normal)
        loginSignUpBtn.backgroundColor = .appPink
        loginSignUpBtn.layer.cornerRadius = 20
    }
    
    @IBAction func loginSignUpAction(_ sender: Any) {
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let err = error {
                print(err.localizedDescription )
            } else{
                let db = Firestore.firestore()
                
                guard let uid = result?.user.uid else {return}
                
                db.collection("users").addDocument(data:["email":email, "uid": uid, "savedImages": []]) { _ in}
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
}
