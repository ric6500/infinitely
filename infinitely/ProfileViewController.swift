//
//  ProfileViewController.swift
//  infinitely
//
//  Created by Riccardo Petrucci on 09/01/23.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailProfileLabel: UILabel!
    
    var imagesList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupProfileData()
    }
    
//    check if user is logged in and fetch data from Firebase
    
    func setupProfileData() {
        if Auth.auth().currentUser == nil {
            guard let loginSignUpPage = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginSignUpViewController") as? LoginSignUpViewController else {return}
            
            self.navigationController?.pushViewController(loginSignUpPage, animated: true)
        } else {
            let db = Firestore.firestore()
            
            guard let uid = Auth.auth().currentUser?.uid else {return}
            guard let email = Auth.auth().currentUser?.email else {return}
            
            emailProfileLabel.text = email
            
            db.collection("users").whereField("uid", isEqualTo: uid).getDocuments { snap, err in
                
                guard let savedImages = snap?.documents.first?.get("savedImages") as? Array<String> else {return}
                
                self.imagesList = savedImages
                self.tableView.reloadData()
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let profileImageCell = tableView.dequeueReusableCell(withIdentifier: "profileImageCell", for: indexPath) as! InspirationImageCell
        
        profileImageCell.inspirationImageView.loadFrom(URLAddress: imagesList[indexPath.row])
        
        return profileImageCell
    }
    
    
  
    
    
    
}
