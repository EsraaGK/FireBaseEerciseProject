//
//  Extensions.swift
//  FireBaseEerciseProject
//
//  Created by EsraaGK on 11/25/19.
//  Copyright © 2019 EsraaGK. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {

   func setRounded() {
    let radius = self.frame.width / 2
      self.layer.cornerRadius = radius
      self.layer.masksToBounds = true
    self.clipsToBounds = true
    self.layer.borderWidth = 1
   }
}
