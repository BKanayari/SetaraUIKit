//
//  AddParticipantViewController.swift
//  Setara
//
//  Created by bernardus kanayari on 03/04/24.
//

import UIKit

class AddParticipantViewController: UIViewController {

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

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(lblNavigationSubtitle)
    view.addSubview(imgParticipant)
    view.addSubview(lblParticipantImage)
    view.addSubview(addParticipantBtn)
    setConstraint()
    navTitle()
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
      addParticipantBtn.heightAnchor.constraint(equalToConstant: 40)
    ])
  }

  func navTitle() {
    self.navigationItem.title = "Participants"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationItem.largeTitleDisplayMode = .always
  }

  @objc private func showAlert() {
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
      print("Parcipant Name: \(participantName)")
    }))
    
    present(alert, animated: true)
  }
}
