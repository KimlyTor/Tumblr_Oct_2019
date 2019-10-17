//
//  PhotoCell.swift
//  Tumblr_Oct_2019
//
//  Created by KimlyT. on 10/17/19.
//  Copyright © 2019 KimlyT. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
