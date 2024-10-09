//
//  sheetAddItemViewController.swift
//  Setara
//
//  Created by Irvan P. Saragi on 31/03/24.
//

import UIKit
class sheetAddItemViewController: UIViewController {

  let viewModel = CoreDataManager()

  @IBOutlet weak var lblAddItem: UILabel!
  @IBOutlet weak var btnClose: UIButton!
  @IBOutlet weak var containerItem: UIView!
  @IBOutlet weak var lblItem: UIView!
  @IBOutlet weak var txtFieldItem: UITextField!
  @IBOutlet weak var lblBasePrice: UILabel!
  @IBOutlet weak var containerBasePrice: UIView!
  @IBOutlet weak var txtFieldPrice: UITextField!
  @IBOutlet weak var lblQuantity: UILabel!
  @IBOutlet weak var txtFieldQuantity: UITextField!
  @IBOutlet weak var lblTax: UILabel!
  @IBOutlet weak var txtFieldTax: UITextField!
  @IBOutlet weak var lblFee: UILabel!
  @IBOutlet weak var txtFieldFee: UITextField!
  @IBOutlet weak var textFieldDiscount: UITextField!
  @IBOutlet weak var lblDiscount: UILabel!

  weak var delegate: BillNavigator?
  
  static var itemList : [Item] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    styleView()
    fetchCoreData()
    overrideUserInterfaceStyle = .dark
    view.backgroundColor = .black

    txtFieldTax.delegate = self
    txtFieldFee.delegate = self
    textFieldDiscount.delegate = self
  }
  
  
  @IBAction func didTapClose() {
    self.dismiss(animated: true)
  }
  
  @IBAction func btnSave(_ sender: Any) {
    //TODO: Save data to core data
    saveItem()
    delegate?.didSaveData()
    delegate?.navigateToCalculateBill()
    self.dismiss(animated: true)
  }
  
  func fetchCoreData(){
    if let fetchParticipant = viewModel.fetchItem(){
      sheetAddItemViewController.itemList = fetchParticipant
      for item in sheetAddItemViewController.itemList {
        print([item.nameItem])
      }
    }
  }
  
  func styleView(){
    containerItem.layer.cornerRadius = 10
    containerBasePrice.layer.cornerRadius = 10
  }
  
  func saveItem() {
    let tax1 = txtFieldTax.text ?? "0"
    let fee1 = txtFieldFee.text ?? "0"
    let disc1 = textFieldDiscount.text ?? "0"

    guard let nameItem = txtFieldItem.text,
          let priceItem = Double(txtFieldPrice.text ?? "0"),
          let quantity = Int(txtFieldQuantity.text ?? "0"),
          let tax = Int(tax1.removePercent),
          let fee = Int(fee1.removePercent),
          let discount = Int(disc1.removePercent)
    else {
      return
    }

    guard let addItem = viewModel.addItem(itemName: nameItem, itemPrice: priceItem, quantity: quantity, tax: tax, fee: fee, discount: discount) else {
      return
    }
    sheetAddItemViewController.itemList.append(addItem)
    delegate?.didSaveData()
  }
}

extension sheetAddItemViewController: UITextFieldDelegate {
  // Adding percent sign after user input some number in the textfield
  func textFieldDidEndEditing(_ textField: UITextField) {
    if textField == textFieldDiscount || (txtFieldFee != nil) || (txtFieldTax != nil) {
      if var text = textField.text, !text.isEmpty {
        text = text.replacingOccurrences(of: "%", with: "")

        textField.text = "\(text)%"
      }
    }
  }
}

extension String {
  var removePercent: String {
    replacingOccurrences(of: "%", with: "")
  }
}
