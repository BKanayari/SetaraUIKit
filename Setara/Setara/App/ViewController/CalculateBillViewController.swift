//
//  CalculateBillViewController.swift
//  Setara
//
//  Created by Irvan P. Saragi on 01/04/24.
//

import UIKit

class CalculateBillViewController: UIViewController {
  
  @IBOutlet weak var lblSeconTitle: UILabel!
  @IBOutlet weak var tableViewBill: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    overrideUserInterfaceStyle = .dark
    title = "Add Bills"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Bill", style: .plain, target: nil, action: nil)
    configureTableView()
    
  }
  
  func configureTableView(){
    tableViewBill.separatorStyle = .none
    tableViewBill.delegate = self
    tableViewBill.dataSource = self
    tableViewBill.register(UINib(nibName: "BillsViewCell", bundle: nil), forCellReuseIdentifier: "BillsViewCell")
  }
  
  @IBAction func didTapDone(_ sender: Any) {
    print("Done")
  }
  
}

extension CalculateBillViewController: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "BillsViewCell", for: indexPath)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

