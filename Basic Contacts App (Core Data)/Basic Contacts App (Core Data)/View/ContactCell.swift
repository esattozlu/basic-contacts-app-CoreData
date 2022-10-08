//
//  ContactCell.swift
//  Basic Contacts App (Core Data)
//
//  Created by Hasan Esat Tozlu on 20.09.2022.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var contactSummaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
