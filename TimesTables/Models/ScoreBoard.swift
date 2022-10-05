//
//  ScoreBoard.swift
//  TimesTables
//
//  Created by Zaid Neurothrone on 2022-10-05.
//

import SwiftUI

final class ScoreBoard: ObservableObject {
  @Published var rounds: [GameRound] = []
}
