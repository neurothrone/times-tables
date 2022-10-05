//
//  Difficulty.swift
//  TimesTables
//
//  Created by Zaid Neurothrone on 2022-10-05.
//

import Foundation

enum Difficulty: String {
  case easy, medium, hard
}

extension Difficulty: Identifiable, CaseIterable {
  var id: Self { self }
  
  var questions: Int {
    switch self {
    case .easy:
      return 5
    case .medium:
      return 10
    case .hard:
      return 20
    }
  }
}
