//
//  ImageListCell.swift
//  ListLoader
//
//  Created by Eslam Shaker on 30/07/2022.
//

import UIKit

class ImageListCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var image: Image! {
        didSet {
            if let url = URL(string: image.previewURL) {
                thumbnailImageView.loadDownsampledImage(url: url)
            }
            usernameLabel.text = image.user
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionStyle = .none
    }
    
}
