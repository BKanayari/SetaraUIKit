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
    delegate?.navigateToCalculateBill()
    delegate?.didSaveData()
    self.dismiss(animated: true)
    saveItem()
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
      guard let nameItem = txtFieldItem.text,
            let priceItem = Double(txtFieldPrice.text ?? "0"),
            let quantity = Int(txtFieldQuantity.text ?? "0"),
            let tax = Int(txtFieldTax.text ?? "0"),
            let fee = Int(txtFieldFee.text ?? "0"),
            let discount = Int(textFieldDiscount.text ?? "0")
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
