//
//  ScoreboardScreen.swift
//  TimesTables
//
//  Created by Zaid Neurothrone on 2022-10-05.
//

import SwiftUI

struct ScoreboardScreen: View {
  @EnvironmentObject private var scoreBoard: ScoreBoard
  
  var body: some View {
    content
  }
  
  var content: some View {
    VStack {
      if scoreBoard.rounds.isEmpty {
        Text("No rounds played yet...")
          .font(.subheadline)
      } else {
        List {
          Section {
            ForEach(scoreBoard.rounds) { round in
              HStack {
                Text("\(round.correctAnswers) / \(round.difficulty.questions)")
                Spacer()
                Text(round.difficulty.rawValue.capitalized)
              }
              .listRowBackground(Color.orange.opacity(0.2))
            }
          } header: {
            HStack {
              Text("Score")
              Spacer()
              Text("Difficulty")
            }
            .textCase(.none)
          }
        }
        .scrollContentBackground(.hidden)
      }
      
      Spacer()
    }
  }
}

struct ScoreboardScreen_Previews: PreviewProvider {
  static var previews: some View {
    let scoreboard = ScoreBoard()
    scoreboard.rounds = GameRound.Preview.samples
    
    return ScoreboardScreen()
      .environmentObject(scoreboard)
  }
}
