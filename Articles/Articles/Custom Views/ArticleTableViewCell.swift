//
//  ArticleTableViewCell.swift
//  Articles
//
//  Created by Tauqeer Ahmed Khan on 11/11/18.
//  Copyright © 2018 Tauqeer Ahmed Khan. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abstarctLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func configureCell(_ article: ArticleCellViewModel){
        self.titleLabel.text = article.title
        self.abstarctLabel.text = article.abstract
        self.dateLabel.text = article.date
    }
}
