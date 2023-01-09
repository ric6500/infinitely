//
//  imageCell.swift
//  infinitely
//
//  Created by Riccardo Petrucci on 09/01/23.
//

import UIKit

class InspirationImageCell: UITableViewCell {
    
    @IBOutlet weak var inspirationImageView: UIImageView!
    
    var imageUrl = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageCell()
    }
    
    func setupImageCell() {
        self.selectionStyle = .none
        self.inspirationImageView.contentMode = .scaleAspectFill
        self.inspirationImageView.layer.cornerRadius = 20
        self.inspirationImageView.layer.borderWidth = 4
        self.inspirationImageView.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 0.7).cgColor
    }
    
}
