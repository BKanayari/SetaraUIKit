//
//  BillsViewCell.swift
//  Setara
//
//  Created by Irvan P. Saragi on 01/04/24.
//

import UIKit

class BillsViewCell: UITableViewCell {
  
  var didTapAddParticipant : (() ->Void)?
  
  @IBOutlet weak var containerCellBill: UIView!
  @IBOutlet weak var lblMenuBill: UILabel!
  @IBOutlet weak var lblTotalPrice: UILabel!
  @IBOutlet weak var btnEdit: UIButton!
  @IBOutlet weak var lblParticipant: UILabel!
  @IBOutlet weak var lblNameParticipant: UILabel!
  @IBOutlet weak var btnAddParticipant: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    containerCellBill.layer.cornerRadius = 10
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    lblParticipant.text = "participant :".localized()
    // Configure the view for the selected state
  }
  
  
  @IBAction func didTapEdit(_ sender: Any) {
    print("Edit")
  }
  
  @IBAction func didTapAddParticipant(_ sender: Any) {
    didTapAddParticipant?()
  }
  
}
