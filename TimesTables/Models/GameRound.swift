//
//  GameRound.swift
//  TimesTables
//
//  Created by Zaid Neurothrone on 2022-10-05.
//

import Foundation

struct GameRound: Identifiable {
  let id = UUID().uuidString
  let correctAnswers: Int
  let difficulty: Difficulty
}
