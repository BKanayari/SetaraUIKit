//
//  SummaryViewCell.swift
//  Setara
//
//  Created by Irvan P. Saragi on 02/04/24.
//

import UIKit

class SummaryViewCell: UITableViewCell {
  
  @IBOutlet weak var containerSummary: UIView!
  @IBOutlet weak var lblNameMember: UILabel!
  @IBOutlet weak var lblTotalPriceMember: UILabel!
  
  @IBOutlet weak var tblViewSummary: UITableView!
  
  struct MenuItem {
    let name: String
    let price: Double
  }
  
  // Create an array containing the dummy data
  var menuItems: [MenuItem] = [
    MenuItem(name: "Tarempa", price: 10.99),
    MenuItem(name: "Mie Goreng", price: 8.50),
    MenuItem(name: "Bubur", price: 12.25),
    MenuItem(name: "Tax", price: 10),
    MenuItem(name: "Fee", price:0)
    // Add more dummy data as needed
  ]
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configTableViewSummaryUser()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  func configTableViewSummaryUser(){
    lblNameMember.text = "Irvan"
    containerSummary.layer.cornerRadius = 10
    tblViewSummary.delegate = self
    tblViewSummary.dataSource = self
    tblViewSummary.register(UINib(nibName: "MenuViewCell", bundle: nil), forCellReuseIdentifier: "MenuViewCell")
  }
}

extension SummaryViewCell: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    menuItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MenuViewCell", for: indexPath) as! MenuViewCell
    
    // Configure the cell with the data from the array
    let menuItem = menuItems[indexPath.row]
    cell.lblMenu.text = menuItem.name
    cell.lblPriceMenu.text = "$\(menuItem.price)"
    return cell
  }
}
