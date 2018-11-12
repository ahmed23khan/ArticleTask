//
//  DetailTableViewCell.swift
//  Articles
//
//  Created by Tauqeer Ahmed Khan on 12/11/18.
//  Copyright © 2018 Tauqeer Ahmed Khan. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func ConfigureCell(_ article: Article?){
        if let article = article {
            
            if let title = article.title {
                self.titleLabel.text = title
            }
        }
    }
}
