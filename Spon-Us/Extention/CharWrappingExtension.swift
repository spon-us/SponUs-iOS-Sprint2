//
//  BreakByChar.swift
//  Spon-Us
//
//  Created by 박현수 on 5/16/24.
//

import Foundation

extension String {
  var forceCharWrapping: Self {
    self.map({ String($0) }).joined(separator: "\u{200B}")
  }
}
