//
//  Extension+Localize.swift
//  Setara
//
//  Created by Irvan P. Saragi on 28/03/24.
//

import Foundation
import UIKit

extension String {
  func localized() -> String {
    return NSLocalizedString(self, comment: self)
  }
}
