//
//  ShowDetailsVC.swift
//  Basic Contacts App (Core Data)
//
//  Created by Hasan Esat Tozlu on 20.09.2022.
//

import UIKit

class ShowDetailsVC: UIViewController {

    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var phoneNumbLabel: UILabel!
    
    var contact: Contacts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let contact = contact {
            contactNameLabel.text = contact.contact_name
            phoneNumbLabel.text = contact.contact_phone
        }
    
    }
    



}
