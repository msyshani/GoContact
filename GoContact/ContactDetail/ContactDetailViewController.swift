//
//  ContactDetailViewController.swift
//  GoContact
//
//  Created by Mahendra Yadav on 20/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    var presenter: ContactDetailViewToPresenterProtocol?
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactImage.layer.cornerRadius = 75
        contactImage.layer.borderColor = UIColor.white.cgColor
        contactImage.layer.borderWidth = 5.0
        self.presenter?.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func messageButtonClicked(_ sender: Any) {
        self.presenter?.sendMessage()
    }
    
    @IBAction func callButtonClicked(_ sender: Any) {
        self.presenter?.makeCall()
    }
    
    @IBAction func emailButtonClicked(_ sender: Any) {
        self.presenter?.sendEmail()
    }
    
    @IBAction func favouriteButtonClicked(_ sender: Any) {
        self.presenter?.makeFavaourite()
    }
    
    @IBAction func EditContact(){
        presenter?.editContact()
    }
    

}


extension ContactDetailViewController : ContactDetailPresenterToViewProtocol{
    func showContactDetail(forContact model: ContactEntity) {
        if let imageStr = model.profilePicUrl{
            ImageDownloader.downloader.getDownloadedImage(urlStr: imageStr) { (image) in
                if let img = image{
                    self.contactImage.image = img
                }
            }
        }
        contactName.text = [model.firstName, model.lastName].compactMap{ $0 }.joined(separator: " ")
        
        if model.isFavorite{
            favouriteButton.isHidden = false
            favouriteButton.setImage( #imageLiteral(resourceName: "home_favourite"), for: .normal)
        }else{
            favouriteButton.setImage( #imageLiteral(resourceName: "favourite_button"), for: .normal)
        }
        
        if let email = model.email{
            self.emailLabel.text = email
        }
        
        if let mobile = model.phoneNumber{
            self.mobileLabel.text = mobile
        }
    }
    
    func displayError(errorMessage: String) {
        let alert = UIAlertController(title: "GoContact", message: errorMessage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showViewController(viewToPresent:Any){
        if let sourceView = viewToPresent as? UIViewController {
            self.present(sourceView, animated: true, completion: nil)
        }
    }
    
    
}
