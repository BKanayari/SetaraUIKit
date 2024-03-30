//
//  HistoryViewCell.swift
//  Setara
//
//  Created by Irvan P. Saragi on 30/03/24.
//

import UIKit

class HistoryViewCell: UITableViewCell {
  
  @IBOutlet weak var lblDateBill: UILabel!
  @IBOutlet weak var lblTotalAmount: UILabel!
  @IBOutlet weak var btnDetaill: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  
  @IBAction func doDetailHistory(_ sender: Any) {
    print("History Detail")
  }
  
}
