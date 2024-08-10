//
//  HomeViewController.swift
//  Setara
//
//  Created by Irvan P. Saragi on 28/03/24.
//

import UIKit

class HomeViewController: UIViewController {
  
  private let tableView : UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    return table
  }()
  
  private let name : UILabel = {
    let label = UILabel()
    label.text = "welcome".localized()
    label.textColor = .black
    label.font = .systemFont(ofSize: 20, weight: .semibold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let textFieldName : UITextField = {
    let textfield = UITextField()
    textfield.placeholder = "Name"
    textfield.borderStyle = .line
    textfield.translatesAutoresizingMaskIntoConstraints = false
    return textfield
  }()
  
  private let buttonName: UIButton = {
    let button = UIButton()
    button.setTitle("Get Name", for: .normal)
    button.backgroundColor = .yellow
    button.addTarget(nil, action: #selector(nameFromTextField), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  var allParticipant : [Participants] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(textFieldName)
    view.addSubview(buttonName)
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    setConstraint()
    
    coreData()
  }
  
  func setConstraint(){
    NSLayoutConstraint.activate([
      textFieldName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      textFieldName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      buttonName.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 20),
      buttonName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      tableView.topAnchor.constraint(equalTo: buttonName.bottomAnchor, constant: 20),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
    ])
  }
  
  @objc func nameFromTextField(){
    tableView.reloadData()
    guard let name = textFieldName.text else { return }
    let addNewParticipant = CoreDataManager.shared.createParticipant(name: name)
    textFieldName.text = ""
    
  }
  
  func coreData(){
    if let fetchedParticipants = CoreDataManager.shared.fetchParticipants() {
      allParticipant = fetchedParticipants
    }
  }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    allParticipant.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    let participant = allParticipant[indexPath.row]
    cell.textLabel?.text = participant.name
    return cell
  }
}
