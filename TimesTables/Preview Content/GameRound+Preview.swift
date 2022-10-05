//
//  GameRound+Preview.swift
//  TimesTables
//
//  Created by Zaid Neurothrone on 2022-10-05.
//

import Foundation

extension GameRound {
  enum Preview {
    static var samples: [GameRound] {
      [
        GameRound(correctAnswers: 1, difficulty: .easy),
        GameRound(correctAnswers: 3, difficulty: .medium),
        GameRound(correctAnswers: 7, difficulty: .hard)
      ]
    }
  }
}
