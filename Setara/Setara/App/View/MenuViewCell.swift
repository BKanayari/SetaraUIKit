//
//  MenuViewCell.swift
//  Setara
//
//  Created by Irvan P. Saragi on 02/04/24.
//

import UIKit

class MenuViewCell: UITableViewCell {
  
  @IBOutlet weak var lblMenu: UILabel!
  @IBOutlet weak var lblPriceMenu: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
