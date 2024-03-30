//
//  AddBillViewController.swift
//  Setara
//
//  Created by Irvan P. Saragi on 30/03/24.
//

import UIKit

enum MenuBill : Int {
  case newBill
  case history
}

class AddBillViewController: UIViewController {
  
  @IBOutlet weak var segmentedBill: UISegmentedControl!
  @IBOutlet weak var imgBill: UIImageView!
  @IBOutlet weak var lblCaptionBill: UILabel!
  @IBOutlet weak var lblProgres: UILabel!
  @IBOutlet weak var progresView: UIProgressView!
  @IBOutlet weak var addNewBill: UIButton!
  @IBOutlet weak var tblHistory: UITableView!
  
  var mockData = 2
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tblHistory.delegate = self
    tblHistory.dataSource = self
    tblHistory.register(UINib(nibName: "HistoryViewCell", bundle: nil), forCellReuseIdentifier: "HistoryViewCell")
    lblCaptionBill.text = "Add_new_bill_caption".localized()
    lblProgres.text = "1 of 3"
    addNewBill.setTitle("Add New Bill", for: .normal)
  }
  
  @IBAction func addNewBill(_ sender: Any) {
    print("addBill")
  }
  
  @IBAction func menuBill(_ sender: UISegmentedControl) {
    chooseMenu(menu: sender.selectedSegmentIndex)
  }
  
  func responseNewBill(){
    lblCaptionBill.text = "Add_new_bill_caption".localized()
    imgBill.image = UIImage(named: "img-bill")
    addNewBill.isHidden = false
    tblHistory.isHidden = true
  }
  
  func responseHistory(){
    
    if mockData == 0 {
      lblCaptionBill.text = "no_bills_history".localized()
      imgBill.image = UIImage(named: "img-history")
    } else {
      tblHistory.isHidden = false
      lblCaptionBill.text = ""
      imgBill.image = UIImage(named: "")
      addNewBill.isHidden = true
    }
  }
  
  func chooseMenu(menu : Int){
    guard let selectedMenu = MenuBill(rawValue: menu) else { return }
    switch selectedMenu {
    case .newBill:
      responseNewBill()
    case .history:
      responseHistory()
    }
  }
}

extension AddBillViewController: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    mockData
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryViewCell", for: indexPath)
    return cell
  }
}
