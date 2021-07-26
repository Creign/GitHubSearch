//
//  SearchTableViewCell.swift
//  GithubSearch
//
//  Created by Excell on 15/07/2021.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var url: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setLabel(model: SearchItemDataType) {
        self.name.text = model.name
        self.url.text = model.html_url?.replacingOccurrences(of: "https://github.com/Creign/", with: "")
    }
}
