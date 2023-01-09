//
//  ViewController.swift
//  infinitely
//
//  Created by Riccardo Petrucci on 09/01/23.
//

import UIKit

class InspirationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    
    
    var numberOfImages = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfImages
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageViewCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! InspirationImageCell
        
        loadImageForCell(imageViewCell: imageViewCell)
        
        detectIfLastImage(index: indexPath.row)
        
        return imageViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let imageViewCell = tableView.cellForRow(at: indexPath) as! InspirationImageCell
        
        guard let detailedPage = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailedPage") as? DetailedPage else {return}
        
        
        detailedPage.imageUrl = imageViewCell.imageUrl
        
        self.navigationController?.pushViewController(detailedPage, animated: true)
        
    }
    
//  detecting last image in the table and adding 10 more images each time
    
    func detectIfLastImage(index: Int) {
        if index == numberOfImages - 1
        {
            reloadData()
        }
    }
    
    func reloadData() {
        numberOfImages = numberOfImages + 10
        self.tableView.reloadData()
    }
    
//  loading image and saving the complete url randomly picked from picsum
    
    func loadImageForCell(imageViewCell: InspirationImageCell) {
        URLSession.shared.dataTask(with: URL(string: "https://picsum.photos/500")!) { (data, response, error) in
            guard let imgUrl = response?.url?.description else {return}
            
            DispatchQueue.main.async {
                imageViewCell.imageUrl = imgUrl
                imageViewCell.inspirationImageView.loadFrom(URLAddress: imageViewCell.imageUrl)
            }
        }.resume()
    }
    

}



