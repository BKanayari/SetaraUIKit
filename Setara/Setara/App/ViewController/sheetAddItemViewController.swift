//
//  sheetAddItemViewController.swift
//  Setara
//
//  Created by Irvan P. Saragi on 31/03/24.
//

import UIKit

class sheetAddItemViewController: UIViewController {
  
  
  @IBOutlet weak var lblAddItem: UILabel!
  @IBOutlet weak var btnClose: UIButton!
  @IBOutlet weak var containerItem: UIView!
  @IBOutlet weak var lblItem: UIView!
  @IBOutlet weak var txtFieldItem: UITextField!
  @IBOutlet weak var lblBasePrice: UILabel!
  @IBOutlet weak var containerBasePrice: UIView!
  @IBOutlet weak var lblQuantity: UILabel!
  @IBOutlet weak var txtFieldQuantity: UITextField!
  @IBOutlet weak var lblTax: UILabel!
  @IBOutlet weak var txtFieldTax: UITextField!
  @IBOutlet weak var lblFee: UILabel!
  @IBOutlet weak var txtFieldFee: UITextField!
  @IBOutlet weak var textFieldDiscount: UITextField!
  @IBOutlet weak var lblDiscount: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    styleView()
    overrideUserInterfaceStyle = .dark
    view.backgroundColor = .black
  }
  
  
  @IBAction func didTapClose() {
    self.dismiss(animated: true)
  }
  
  @IBAction func btnSave(_ sender: Any) {
    //TODO: Save data to core data
    print("save")
  }
  
  func styleView(){
    containerItem.layer.cornerRadius = 10
    containerBasePrice.layer.cornerRadius = 10
  }
}
