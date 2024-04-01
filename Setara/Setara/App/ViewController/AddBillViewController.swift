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
  
  var mockData = 3
  let addBillViewModel = AddBillViewModel()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tblHistory.delegate = self
    tblHistory.dataSource = self
    tblHistory.register(UINib(nibName: "HistoryViewCell", bundle: nil), forCellReuseIdentifier: "HistoryViewCell")
    tblHistory.separatorStyle = .none
    tblHistory.rowHeight = 80
    responseNewBill()
    progresView.progress = Float(AddBillViewModel.progres) / 3.0
    lblProgres.text = "\(AddBillViewModel.progres) of 3"
  }
  
  @IBAction func addNewBill(_ sender: Any) {
    //TODO: Navigate to modal add new vill
    self.present(sheetAddItemViewController(), animated: true)
    print("addBill")
    addBillViewModel.progresBar()
    let progressFraction = Float(AddBillViewModel.progres) / 3.0
    self.progresView.progress = progressFraction
    self.lblProgres.text = "\(AddBillViewModel.progres) of 3"
  }
  
  
  @IBAction func menuBill(_ sender: UISegmentedControl) {
    chooseMenu(menu: sender.selectedSegmentIndex)
  }
  
  func responseNewBill(){
    lblCaptionBill.text = "Add_new_bill_caption".localized()
    imgBill.image = UIImage(named: "img-bill")
    addNewBill.isHidden = false
    addNewBill.setTitle("add_new_bill_btn".localized(), for: .normal)
    tblHistory.isHidden = true
  }
  
  func updateUIForResponseHistory() {
    if mockData == 0 {
      showNoBillsHistory()
    } else {
      showBillsHistory()
    }
  }
  
  func showNoBillsHistory() {
    lblCaptionBill.text = NSLocalizedString("no_bills_history", comment: "")
    imgBill.image = UIImage(named: "img-history")
    tblHistory.isHidden = true
    addNewBill.isHidden = false
  }
  
  func showBillsHistory() {
    tblHistory.isHidden = false
    lblCaptionBill.text = ""
    imgBill.image = nil
    addNewBill.isHidden = true
  }
  
  func chooseMenu(menu : Int){
    guard let selectedMenu = MenuBill(rawValue: menu) else { return }
    switch selectedMenu {
    case .newBill:
      responseNewBill()
    case .history:
      updateUIForResponseHistory()
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
