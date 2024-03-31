//
//  HomeViewController.swift
//  Setara
//
//  Created by Irvan P. Saragi on 28/03/24.
//

import UIKit

class HomeViewController: UIViewController {
  
  private let name : UILabel = {
    let label = UILabel()
    label.text = "welcome".localized()
    label.textColor = .black
    label.font = .systemFont(ofSize: 20, weight: .semibold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
    
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(name)
    setConstraint()
  }
  
  func setConstraint(){
    NSLayoutConstraint.activate([
      name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      name.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
  }
}
