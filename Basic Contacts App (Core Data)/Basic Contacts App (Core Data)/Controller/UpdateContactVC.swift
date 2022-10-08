//
//  UpdateContactVC.swift
//  Basic Contacts App (Core Data)
//
//  Created by Hasan Esat Tozlu on 20.09.2022.
//

import UIKit

class UpdateContactVC: UIViewController {

    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var contactNameText: UITextField!
    @IBOutlet weak var phoneNumbText: UITextField!
    
    var contact: Contacts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let contact = contact {
            contactNameText.text = contact.contact_name
            phoneNumbText.text = contact.contact_phone
        }
        
    }
    
    @IBAction func updateButtonClicked(_ sender: Any) {
        
        if let contact = contact, let name = contactNameText.text, let phone = phoneNumbText.text {
            
            contact.contact_name = name
            contact.contact_phone = phone
            appDelegate.saveContext()
            
        }
        navigationController?.popViewController(animated: true)
        
    }
    


}
