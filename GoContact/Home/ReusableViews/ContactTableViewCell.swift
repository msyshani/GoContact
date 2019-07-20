//
//  ContactTableViewCell.swift
//  GoContact
//
//  Created by Mahendra Yadav on 20/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell ,ReusableViewProtocol {
    //ReuseHandler
    static var reuseIdentifier = "ContactTableViewCell"
    static var nib: UINib? {
        return UINib(nibName: String(describing: ContactTableViewCell.self), bundle: nil)
    }
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(model:ContactEntity){
        if let imageStr = model.profilePicUrl{
            ImageDownloader.downloader.getDownloadedImage(urlStr: imageStr) { (image) in
                if let img = image{
                    self.contactImageView.image = img
                }
            }
        }
        contactName.text = [model.firstName, model.lastName].compactMap{ $0 }.joined(separator: " ")
        
    }
    
}
