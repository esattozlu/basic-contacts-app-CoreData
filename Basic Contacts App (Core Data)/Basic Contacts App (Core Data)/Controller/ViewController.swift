//
//  ViewController.swift
//  Basic Contacts App (Core Data)
//
//  Created by Hasan Esat Tozlu on 20.09.2022.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {

    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var contactsTableView: UITableView!
    
    var contactsList = [Contacts]()
    var isSearching = false
    var searchingText: String?
    var searchedContactsList: [Contacts]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        searchBar.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if isSearching {
            searchContacts(contact_name: searchingText!)
        } else {
            getAllContacts()
        }
        contactsTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let index = sender as? Int
        
        if segue.identifier == "toDetails" {
            let destinationVC = segue.destination as! ShowDetailsVC
            destinationVC.contact = contactsList[index!]
        }
        
        if segue.identifier == "toUpdateContact" {
            let destinationVC = segue.destination as! UpdateContactVC
            destinationVC.contact = contactsList[index!]
        }
        
    }
    
    func getAllContacts() {
        
        do {
            contactsList = try context.fetch(Contacts.fetchRequest())
        } catch {
            print("Contacts fetching error!")
        }
        
    }
    
    func searchContacts(contact_name: String) {
        
        let fetchRequest: NSFetchRequest<Contacts> = Contacts.fetchRequest()
        
        //fetchRequest.predicate = NSPredicate(format: "contact_name CONTAINS %@", contact_name)
        
        do {
            contactsList = try context.fetch(fetchRequest)
            contactsList = contactsList.filter({$0.contact_name!.lowercased().contains(contact_name.lowercased())})
        } catch {
            print("Contacts fetching error!")
        }
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = contactsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactCell
        cell.contactSummaryLabel.text = contact.contact_name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetails", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contextualAction, view, boolValue in
            print("Delete clicked \(self.contactsList[indexPath.row])")
            let kisi = self.contactsList[indexPath.row]
            self.context.delete(kisi)
            appDelegate.saveContext()
    
            if self.isSearching {
                self.searchContacts(contact_name: self.searchingText!)
            } else {
                self.getAllContacts()
            }
            self.contactsTableView.reloadData()
        }
        
        let updateAction = UIContextualAction(style: .normal, title: "Update") { contextualAction, view, boolValue in
            print("Update clicked \(self.contactsList[indexPath.row])")
            self.performSegue(withIdentifier: "toUpdateContact", sender: indexPath.row)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, updateAction])
        
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Arama \(searchText)")
        
        searchingText = searchText
        if searchText == "" {
            isSearching = false
            getAllContacts()
        } else {
            isSearching = true
            searchContacts(contact_name: searchText)
        }
        contactsTableView.reloadData()
    }
    
}
