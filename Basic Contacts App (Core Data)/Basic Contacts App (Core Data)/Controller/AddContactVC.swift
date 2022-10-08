//
//  AddContactVC.swift
//  Basic Contacts App (Core Data)
//
//  Created by Hasan Esat Tozlu on 20.09.2022.
//

import UIKit

class AddContactVC: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var contactNameText: UITextField!
    @IBOutlet weak var phoneNumbText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func addButtonClicked(_ sender: Any) {
        
        if let name = contactNameText.text, let phone = phoneNumbText.text {
            
            let contact = Contacts(context: context)
            contact.contact_name = name
            contact.contact_phone = phone
            appDelegate.saveContext()
            
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
}
