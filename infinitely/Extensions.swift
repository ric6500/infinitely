//
//  imageViewExtension.swift
//  infinitely
//
//  Created by Riccardo Petrucci on 09/01/23.
//

import UIKit

extension UIImageView {
    
//  load image data from url and assigned to image
    
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          guard let imageData = data else { return }
            
            DispatchQueue.main.async {
                    self.image = UIImage(data: imageData)
                  }
        }.resume()
        
    }
    
}

extension UIColor {
    
    static var appPink: UIColor {
        return UIColor(red: 247/255, green: 83/255, blue: 197/255, alpha: 1)
    }
}
