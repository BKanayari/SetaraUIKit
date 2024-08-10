//
//  TableViewCell.swift
//  Setara
//
//  Created by Irvan P. Saragi on 08/04/24.
//

import UIKit

class ParticipantCell: UITableViewCell {
  
  let containerView : UIView = {
    let view = UIView()
    view.backgroundColor = .primaryGray
    view.layer.cornerRadius = 20
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let lblName: UILabel = {
    let label = UILabel()
    label.text = "Name"
    label.textColor = .white
    label.font = .systemFont(ofSize: 17, weight: .regular)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let imgCheckList: UIImageView = {
    let image = UIImageView()
    image.tintColor = .white
    image.image = UIImage(systemName: "checkmark")
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addSubview(containerView)
    addSubview(lblName)
    addSubview(imgCheckList)
    setConstraint()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
  func setConstraint(){
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
      containerView.heightAnchor.constraint(equalToConstant: 60),
      
      lblName.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      lblName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
      
      imgCheckList.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
      imgCheckList.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
    ])
  }
  
}
