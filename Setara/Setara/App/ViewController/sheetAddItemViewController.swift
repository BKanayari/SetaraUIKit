//
//  sheetAddItemViewController.swift
//  Setara
//
//  Created by Irvan P. Saragi on 31/03/24.
//

import UIKit
class sheetAddItemViewController: UIViewController {

  let viewModel = CoreDataManager()

  // MARK: UI Outlets
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

  // MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupTextFieldsDelegate()
    addTextFieldTargets()
    setupKeyboardDismissGesture()
    updateSaveButtonState()
  }

  // MARK: Button Action
  @IBAction func didTapClose() {
    self.dismiss(animated: true)
  }

  @IBAction func btnSave(_ sender: Any) {
    saveItem()
    delegate?.didSaveData()
    delegate?.navigateToCalculateBill()
    self.dismiss(animated: true)
  }

  // MARK: Setup Methods
  private func setupUI() {
    styleView()
    fetchCoreData()
    overrideUserInterfaceStyle = .dark
    view.backgroundColor = .black
  }

  /// Assigning textfield delegate to it self
  private func setupTextFieldsDelegate() {
    let textFields: [UITextField] = [txtFieldPrice, txtFieldTax, txtFieldFee, textFieldDiscount]
    textFields.forEach { $0.delegate = self }
  }

  /// Adding Textfield Target
  private func addTextFieldTargets() {
    let textFields: [UITextField] = [txtFieldItem, txtFieldPrice, txtFieldQuantity, txtFieldTax, txtFieldFee, textFieldDiscount]
    textFields.forEach {
      $0.addTarget(self, action: #selector(textFieldDidChangeSelection), for: .allEditingEvents)
    }
  }

  /// Recognize tap to dismiss keyboard
  private func setupKeyboardDismissGesture() {
    let tapToDismissKeyboard = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(tapToDismissKeyboard)
  }

  /// Validate if all textfields are filled
  private func validateAllTextfields() -> Bool {
    let fields = [txtFieldItem, txtFieldPrice, txtFieldQuantity, txtFieldTax, txtFieldFee, textFieldDiscount]
    return fields.allSatisfy { !($0?.text?.isEmpty ?? true) }
  }

  /// Disable save the button before user filled all textfileld
  private func updateSaveButtonState() {
    btnSave.isEnabled = validateAllTextfields()
    btnSave.alpha = btnSave.isEnabled ? 1.0 : 0.8
  }

  /// Dismiss keyboard
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }

  /// Call updateSaveButtonState when text changes
  @objc func textFieldDidChangeSelection(_ textField: UITextField) {
    updateSaveButtonState()

    /// Format for price nominal separator
    if textField == txtFieldPrice {
      formatPriceTextField(textField)
    }
  }

  private func formatPriceTextField(_ textField: UITextField) {
    guard let text = textField.text?.replacingOccurrences(of: ".", with: ""), let number = Int(text) else { return }
    textField.text = formatNumber(number)
  }

  /// Format number by adding dot as a thousands separator
  private func formatNumber(_ number: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = "."
    formatter.groupingSize = 3
    return formatter.string(from: NSNumber(value: number)) ?? ""
  }

  private func fetchCoreData(){
    if let fetchParticipant = viewModel.fetchItem(){
      sheetAddItemViewController.itemList = fetchParticipant
    }
  }

  func styleView(){
    [containerItem, containerBasePrice].forEach { $0?.layer.cornerRadius = 10 }
  }

  func saveItem() {
    let priceItem1 = txtFieldPrice.text ?? "0"
    let tax1 = txtFieldTax.text ?? "0"
    let fee1 = txtFieldFee.text ?? "0"
    let disc1 = textFieldDiscount.text ?? "0"

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
