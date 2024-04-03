//
//  HomeViewModel.swift
//  Setara
//
//  Created by Irvan P. Saragi on 28/03/24.
//

import UIKit

class AddBillViewModel {
  static var progres = 0


  func progresBar(){
    if AddBillViewModel.progres < 3{
      AddBillViewModel.progres += 1
    }
  }
}

