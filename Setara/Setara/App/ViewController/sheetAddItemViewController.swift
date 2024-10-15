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
  @IBOutlet weak var btnSave: UIButton!

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
    txtFieldPrice.delegate = self

    /// Add target for text field changes
    txtFieldItem.addTarget(self, action: #selector(textFieldDidChangeSelection), for: .allEditingEvents)
    txtFieldPrice.addTarget(self, action: #selector(textFieldDidChangeSelection), for: .allEditingEvents)
    txtFieldQuantity.addTarget(self, action: #selector(textFieldDidChangeSelection), for: .allEditingEvents)
    txtFieldTax.addTarget(self, action: #selector(textFieldDidChangeSelection), for: .allEditingEvents)
    txtFieldFee.addTarget(self, action: #selector(textFieldDidChangeSelection), for: .allEditingEvents)
    textFieldDiscount.addTarget(self, action: #selector(textFieldDidChangeSelection), for: .allEditingEvents)

    updateSaveButtonState()
  }

  @IBAction func didTapClose() {
    self.dismiss(animated: true)
  }

  @IBAction func btnSave(_ sender: Any) {
    saveItem()
    delegate?.didSaveData()
    delegate?.navigateToCalculateBill()
    self.dismiss(animated: true)
  }

  /// Validate if all textfields are filled
  func validateAllTextfields() -> Bool {
    if txtFieldItem.text?.isEmpty == true ||
       txtFieldPrice.text?.isEmpty == true ||
       txtFieldQuantity.text?.isEmpty == true ||
       txtFieldTax.text?.isEmpty == true ||
       txtFieldFee.text?.isEmpty == true ||
       textFieldDiscount.text?.isEmpty == true {
        return false
    }
    return true
  }

  /// Disable save the button before user filled all textfileld
  func updateSaveButtonState() {
    if validateAllTextfields() {
        btnSave.isEnabled = true
        btnSave.alpha = 1.0
    } else {
        btnSave.isEnabled = false
        btnSave.alpha = 0.8
    }
  }

  /// Call updateSaveButtonState when text changes
  @objc func textFieldDidChangeSelection(_ textField: UITextField) {
    updateSaveButtonState()

    /// Format for price nominal separator
    if textField == txtFieldPrice {
        if let text = textField.text?.replacingOccurrences(of: ".", with: ""), let number = Int(text) {
            textField.text = formatNumber(number)
        }
    }
  }

  /// Format number by adding dot as a thousands separator
  func formatNumber(_ number: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = "."
    formatter.groupingSize = 3
    return formatter.string(from: NSNumber(value: number)) ?? ""
  }

  func fetchCoreData(){
    if let fetchParticipant = viewModel.fetchItem(){
      sheetAddItemViewController.itemList = fetchParticipant
    }
  }

  func styleView(){
    containerItem.layer.cornerRadius = 10
    containerBasePrice.layer.cornerRadius = 10
  }

  func saveItem() {
    let priceItem1 = txtFieldPrice.text ?? "0"
    let tax1 = txtFieldTax.text ?? "0"
    let fee1 = txtFieldFee.text ?? "0"
    let disc1 = textFieldDiscount.text ?? "0"

    // TODO: Simplify PriceItem and Quantity logic
    guard let nameItem = txtFieldItem.text,
          let priceItem = Int(priceItem1.nominalSeparator),
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
  /// Adding percent sign after user input some number in the textfield
  func textFieldDidEndEditing(_ textField: UITextField) {
    if (textField == textFieldDiscount || textField == txtFieldFee || textField == txtFieldTax) {
      if var text = textField.text, !text.isEmpty {
        text = text.replacingOccurrences(of: "%", with: "")

        textField.text = "\(text)%"
      }
    }
  }
}
