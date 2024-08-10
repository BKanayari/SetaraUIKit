//
//  CalculateBillViewController.swift
//  Setara
//
//  Created by Irvan P. Saragi on 01/04/24.
//

import UIKit

enum billStatus {
  case noBills
  case thereIsBill
}

class CalculateBillViewController: UIViewController, BillNavigator {
  
  @IBOutlet weak var lblSeconTitle: UILabel!
  @IBOutlet weak var tableViewBill: UITableView!
  
  let dataItem = sheetAddItemViewController.itemList
  var statusBill: billStatus = .noBills

  private let responNoBill : UILabel = {
    let label = UILabel()
    label.text = "There is no bill"
    label.font = .systemFont(ofSize: 30)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    overrideUserInterfaceStyle = .dark
    title = "Add Bills"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Bill", style: .plain, target: self, action: #selector(didTapAddBill))
    responBill()
    configureTableViewBill()
    if dataItem.isEmpty {
      statusBill = .noBills
    } else {
      statusBill = .thereIsBill
    }
    billStatus()
  }
  
  func responBill(){
    view.addSubview(responNoBill)
    NSLayoutConstraint.activate([
      responNoBill.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      responNoBill.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
  }
  
  func configureTableViewBill(){
    tableViewBill.separatorStyle = .none
    tableViewBill.delegate = self
    tableViewBill.dataSource = self
    tableViewBill.register(UINib(nibName: "BillsViewCell", bundle: nil), forCellReuseIdentifier: "BillsViewCell")
    
  }
  
  @IBAction func didTapDone(_ sender: Any) {
    self.navigationController?.pushViewController(SummaryViewController(), animated: true)
    print("Done")
  }
  
  @objc func didTapAddBill(){
    navigateToSheetBill()
  }
  
  func navigateToAddParticipant(){
    self.navigationController?.pushViewController(ParticipantViewController(), animated: false)
  }
  
  func navigateToCalculateBill() {
    self.navigationController?.pushViewController(CalculateBillViewController(), animated: true)
  }
  
  func navigateToSheetBill(){
    let sheetAddItemVC = sheetAddItemViewController(nibName: "sheetAddItemViewController", bundle: nil)
    sheetAddItemVC.delegate = self
    present(sheetAddItemVC, animated: true, completion: nil)
  }
  
  func didSaveData() {
    statusBill = .thereIsBill
    billStatus()
  }
  
  public func billStatus(){
    switch statusBill {
    case .noBills:
      tableViewBill.isHidden = true
      responNoBill.isHidden = false
    case .thereIsBill:
      tableViewBill.isHidden = false
      responNoBill.isHidden = true
    }
  }
}

extension CalculateBillViewController: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataItem.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "BillsViewCell", for: indexPath) as! BillsViewCell
    let item = dataItem[indexPath.row]
    let nameItem = item.nameItem
    cell.lblMenuBill.text = nameItem
    cell.didTapAddParticipant = {
      self.navigateToAddParticipant()
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

