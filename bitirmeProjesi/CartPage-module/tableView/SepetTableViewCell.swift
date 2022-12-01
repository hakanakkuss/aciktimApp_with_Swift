//
//  SepetTableViewCell.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 20.10.2022.
//

import UIKit

class SepetTableViewCell: UITableViewCell {

    @IBOutlet weak var FoodPrice: UILabel!
    @IBOutlet weak var FoodNameL: UILabel!
    @IBOutlet weak var FoodCount: UILabel!
    @IBOutlet weak var FoodImageV: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
}
