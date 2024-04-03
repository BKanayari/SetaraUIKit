//
//  SummaryViewController.swift
//  Setara
//
//  Created by Irvan P. Saragi on 02/04/24.
//

import UIKit

class SummaryViewController: UIViewController {
  
  @IBOutlet weak var lblTotalAmount: UILabel!
  @IBOutlet weak var lblTotalPrice: UILabel!
  @IBOutlet weak var tableViewSummary: UITableView!
  @IBOutlet weak var progresBarView: UIProgressView!
  @IBOutlet weak var lblProgres: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    overrideUserInterfaceStyle = .dark
    title = "Summary"
    navigationController?.navigationBar.prefersLargeTitles = true
    confiTableViewSummary()
  }
  
  @IBAction func didTapFinish(_ sender: Any) {
    print("Finish")
  }
  
  func confiTableViewSummary(){
    tableViewSummary.delegate = self
    tableViewSummary.dataSource = self
    tableViewSummary.register(UINib(nibName: "SummaryViewCell", bundle: nil), forCellReuseIdentifier: "SummaryViewCell")
  }
}

extension SummaryViewController: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryViewCell", for: indexPath)
    return cell
  }
}
