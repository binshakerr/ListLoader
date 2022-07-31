//
//  ImageDetailsCell.swift
//  ListLoader
//
//  Created by Eslam Shaker on 30/07/2022.
//

import UIKit

class ImageDetailsCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    
    //MARK: - Properties
    var image: Image? {
        didSet {
            guard let image = image else { return }
            if let url = URL(string: image.largeImageURL ?? "") {
                mainImageView.loadDownsampledImage(url: url)
            }
            sizeLabel.text = "\(image.imageSize)"
            typeLabel.text = image.type
            tagsLabel.text = image.tags
        }
    }
    
    //MARK: - 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionStyle = .none
    }
    
}
