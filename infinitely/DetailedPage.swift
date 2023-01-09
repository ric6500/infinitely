//
//  detailedPage.swift
//  infinitely
//
//  Created by Riccardo Petrucci on 09/01/23.
//

import UIKit
import Firebase

class DetailedPage: UIViewController {
    
    @IBOutlet weak var detailedImageView: UIImageView!
    @IBOutlet weak var saveBtn: UIButton!
    
    var imageUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetailedImageView()
        setupSaveBtn()
    }
    
    func setupDetailedImageView() {
        detailedImageView.contentMode = .scaleAspectFill
        detailedImageView.layer.cornerRadius = 20
        detailedImageView.layer.borderWidth = 4
        detailedImageView.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 0.7).cgColor
        detailedImageView.loadFrom(URLAddress: self.imageUrl)
    }
    
    func setupSaveBtn() {
        saveBtn.setTitle("Save to favourites", for: .normal)
        saveBtn.setTitleColor(.white, for: .normal)
        saveBtn.backgroundColor = .appPink
        saveBtn.layer.cornerRadius = 20
    }
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        
        if Auth.auth().currentUser == nil {
            guard let loginSignUpPage = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginSignUpViewController") as? LoginSignUpViewController else {return}
            
            self.navigationController?.pushViewController(loginSignUpPage, animated: true)
        } else {
            
            let db = Firestore.firestore()
            
            guard let uid = Auth.auth().currentUser?.uid else {return}
            
            db.collection("users").whereField("uid", isEqualTo: uid).getDocuments { snap, err in
                guard let docID = snap?.documents.first?.documentID else {return}
                guard var savedImages = snap?.documents.first?.get("savedImages") as? Array<String> else {return}
                
                if savedImages.isEmpty || !savedImages.contains(self.imageUrl) {
                    savedImages.append(self.imageUrl)
                    db.collection("users").document(docID).setData(["savedImages": savedImages], merge: true)
                }
                
            }
            
        }
    }
    
}
