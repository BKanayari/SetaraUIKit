//
//  ParticipantViewController.swift
//  Setara
//
//  Created by Irvan P. Saragi on 08/04/24.
//

import UIKit

enum participantStatus {
  case noParticipant
  case thereIsParticipant
}

class ParticipantViewController: UIViewController{
  
  private let tableViewParticipant: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(ParticipantCell.self, forCellReuseIdentifier: "cell")
    return tableView
  }()
  
  private let addParticipantBtn: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .systemOrange
    button.setTitle("Add Participant", for: .normal)
    button.layer.cornerRadius = 5
    button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
    button.addTarget(nil, action: #selector(showAlert), for: .touchUpInside)
    return button
  }()
  
  private let lblNavigationSubtitle: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Add split bill participants"
    return label
  }()
  
  private let imgParticipant: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.image = UIImage(systemName: "person.3")
    image.tintColor = .white
    return image
  }()
  
  private let lblParticipantImage: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "No participants yet"
    label.font = .systemFont(ofSize: 17, weight: .semibold)
    return label
  }()
  
  private let btnDone: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .systemOrange
    button.setTitle("Done", for: .normal)
    button.layer.cornerRadius = 5
    button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
    button.addTarget(nil, action: #selector(didTapDone), for: .touchUpInside)
    return button
  }()
  
  private let lblProgresView: UILabel = {
    let label = UILabel()
    label.text = "Step 2 of 3"
    label.font = .systemFont(ofSize: 17, weight: .semibold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let progresView : UIProgressView = {
    let progres = UIProgressView()
    progres.translatesAutoresizingMaskIntoConstraints = false
    progres.progress = 0.5
    return progres
  }()
  
  var statusParticipant: participantStatus = .noParticipant
  var participant : [Participants] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchCoreData()
    configureView()
    setTableView()
    setConstraint()
    navTitle()
    if participant.isEmpty {
      statusParticipant = .noParticipant
    } else {
      statusParticipant = .thereIsParticipant
    }
    participantStatus()
  }
  
  func fetchCoreData(){
    if let fetchParticipant = CoreDataManager.shared.fetchParticipants(){
      participant = fetchParticipant
    }
  }
  
  func configureView(){
    view.addSubview(lblNavigationSubtitle)
    view.addSubview(imgParticipant)
    view.addSubview(lblParticipantImage)
    view.addSubview(addParticipantBtn)
    view.addSubview(tableViewParticipant)
    view.addSubview(progresView)
    view.addSubview(lblProgresView)
    view.addSubview(btnDone)
  }
  
  func setTableView(){
    tableViewParticipant.dataSource = self
    tableViewParticipant.delegate = self
    tableViewParticipant.separatorStyle = .none
  }
  
  func setConstraint() {
    NSLayoutConstraint.activate([
      lblNavigationSubtitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      lblNavigationSubtitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
      
      imgParticipant.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      imgParticipant.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      imgParticipant.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 93),
      imgParticipant.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -93),
      imgParticipant.heightAnchor.constraint(equalToConstant: 150),
      
      lblParticipantImage.topAnchor.constraint(equalTo: imgParticipant.bottomAnchor, constant: 2),
      lblParticipantImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      addParticipantBtn.topAnchor.constraint(equalTo: lblParticipantImage.bottomAnchor, constant: 28),
      addParticipantBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 105),
      addParticipantBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -105),
      addParticipantBtn.heightAnchor.constraint(equalToConstant: 40),
      
      btnDone.bottomAnchor.constraint(equalTo: lblProgresView.topAnchor, constant: -16),
      btnDone.widthAnchor.constraint(equalToConstant: 100),
      btnDone.heightAnchor.constraint(equalToConstant: 40),
      btnDone.centerXAnchor.constraint(equalTo: progresView.centerXAnchor),
      
      lblProgresView.bottomAnchor.constraint(equalTo: progresView.topAnchor, constant: -16),
      lblProgresView.centerXAnchor.constraint(equalTo: progresView.centerXAnchor),
      
      progresView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -28),
      progresView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      progresView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      
      tableViewParticipant.topAnchor.constraint(equalTo: lblNavigationSubtitle.bottomAnchor, constant: 28),
      tableViewParticipant.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableViewParticipant.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableViewParticipant.bottomAnchor.constraint(equalTo: btnDone.topAnchor, constant: -16),
    ])
  }
  
  func navTitle() {
    self.navigationItem.title = "Participants"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationItem.largeTitleDisplayMode = .always
  }
  
  func participantStatus(){
    switch statusParticipant {
    case .noParticipant:
      tableViewParticipant.isHidden = true
      btnDone.isHidden = true
    case .thereIsParticipant:
      tableViewParticipant.isHidden = false
      btnDone.isHidden = false
      navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(showAlert))
    }
  }
  
  @objc private func showAlert() {
    statusParticipant = .thereIsParticipant
    let alert = UIAlertController (
      title: "Add Participant",
      message: "Enter participant name",
      preferredStyle: .alert
    )
    
    /// Add textfield on alertView
    alert.addTextField { field in
      field.placeholder = "Participant Name"
    }
    
    /// Add 2 button on the alertView
    alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
    alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
      guard let fields = alert.textFields, fields.count == 1 else { return }
      let participantNameField = fields[0]
      guard let participantName = participantNameField.text, !participantName.isEmpty else {return}
      let addNewParticipant = CoreDataManager.shared.createParticipant(name: participantName)
      self.statusParticipant = .thereIsParticipant
      self.participantStatus()
      self.participant.append(addNewParticipant!)
      DispatchQueue.main.async{
        self.tableViewParticipant.reloadData()
      }
    }))
    
    present(alert, animated: true)
  }
  
  @objc func didTapDone(){
    navigationController?.pushViewController(CalculateBillViewController(), animated: true)
  }
}

extension ParticipantViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    participant.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ParticipantCell
    let participant = participant[indexPath.row]
    let name = participant.name
    cell.lblName.text = name
    return cell
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    true
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete{
      
      let alert = UIAlertController (
        title: "Delete participant?",
        message: "You cannot undo this action",
        preferredStyle: .alert
      )
      alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
      alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [self]_ in
        let deleteParticipant = participant[indexPath.row]
        CoreDataManager().deleteParticipant(participant: deleteParticipant)
        participant.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        if participant.isEmpty {
          statusParticipant = .noParticipant
          participantStatus()
        }
      }))
      present(alert, animated: true)
    }
  }
}
