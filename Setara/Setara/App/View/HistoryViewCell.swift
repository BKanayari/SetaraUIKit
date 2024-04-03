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
  @IBOutlet weak var containerHistory: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    containerHistory.layer.cornerRadius = 10
    btnDetaill.tintColor = .white
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  
  @IBAction func doDetailHistory(_ sender: Any) {
    //TODO: Navigate to detai history and view history detail still empty
    print("History Detail")
  }
}
