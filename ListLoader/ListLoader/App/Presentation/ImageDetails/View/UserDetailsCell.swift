//
//  UserDetailsCell.swift
//  ListLoader
//
//  Created by Eslam Shaker on 30/07/2022.
//

import UIKit

class UserDetailsCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var downloadsLabel: UILabel!
    
    
    //MARK: - Properties
    var image: Image! {
        didSet {
            usernameLabel.text = image.user
            viewsLabel.text = "\(image.views)"
            likesLabel.text = "\(image.likes)"
            commentsLabel.text = "\(image.comments)"
            downloadsLabel.text = "\(image.downloads)"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionStyle = .none
    }
    
}
