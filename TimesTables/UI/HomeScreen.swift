//
//  HomeScreen.swift
//  TimesTables
//
//  Created by Zaid Neurothrone on 2022-10-05.
//

import SwiftUI

struct HomeScreen: View {
  @EnvironmentObject private var scoreBoard: ScoreBoard
  
  @State private var minNumber = 2
  @State private var maxNumber = 12
  @State private var isCustomMultiplicationTable = true

  @State private var selectedDifficulty: Difficulty = .medium
  
  @State private var selectedNumber: Int = .zero
  @State private var isNavigatingToGameScreen = false
  
  var body: some View {
    content
      .navigationDestination(isPresented: $isNavigatingToGameScreen) {
        GameScreen(
          questions: isCustomMultiplicationTable
          ? generateCustomQuestions()
          : generateTableFor(number: selectedNumber)
        ) { correctAnswers in
          addRoundResultsToScoreboardFrom(correctAnswers: correctAnswers)
        }
      }
      .animation(.default, value: isCustomMultiplicationTable)
  }
  
  var content: some View {
    VStack {
      Section {
        Picker("Difficulty (questions)", selection: $selectedDifficulty) {
          ForEach(Difficulty.allCases) { difficulty in
                Text("\(difficulty.rawValue.capitalized) (\(difficulty.questions))")
          }
        }
        .pickerStyle(.segmented)
      } header: {
        HStack {
          Text("Difficulty (Questions)")
            .textCase(.none)
          Spacer()
        }
      }
      
      VStack {
        Toggle("Custom multiplication table?", isOn: $isCustomMultiplicationTable)
        Divider()
      }
      .padding(.top)
      
      
      if isCustomMultiplicationTable {
        customTable
      } else {
        selectedTable
      }
      
      Spacer()
      
      Button {
        isNavigatingToGameScreen.toggle()
      } label: {
        Text("Play")
          .frame(maxWidth: .infinity)
          .padding(.vertical, 10)
      }
      .buttonStyle(.borderedProminent)
      .tint(.purple)
      .disabled(!isCustomMultiplicationTable && selectedNumber == .zero)
    }
  }
  
  var customTable: some View {
    VStack {
        Section {
          Stepper(value: $minNumber, in: 2...maxNumber) {
            StepperLabelView(text: "From number:", value: minNumber)
          }
          Stepper(value: $maxNumber, in: minNumber...12) {
            StepperLabelView(text: "To number:", value: maxNumber)
          }
        } header: {
          Text("Customise Multiplication Tables")
            .font(.headline)
            .textCase(.none)
            .padding(.vertical)
        }
    }
  }
  
  var selectedTable: some View {
    Section {
      MultiplicationTablesView(selectedNumber: $selectedNumber)
    } header: {
      Text("Press on the table you wish to play")
        .font(.headline)
    }
    .padding(.vertical)
  }
}

extension HomeScreen {
  private func generateTableFor(number: Int) -> [Question] {
    var questions: [Question] = []
    
    for multiplier in 1...selectedDifficulty.questions {
      let newQuestion = Question(leftOperand: number, rightOperand: multiplier)
      questions.append(newQuestion)
    }
    
    return questions
  }
  
  private func generateCustomQuestions() -> [Question] {
    var questions: [Question] = []
    
    // Generate questions from all multiplication tables in the range minNumber to maxNumber
    var generatedQuestions: [Question] = []
    
    for currentNum in minNumber...maxNumber {
      for num in 1...currentNum {
        let newQuestion = Question(leftOperand: num, rightOperand: currentNum)
        generatedQuestions.append(newQuestion)
      }
    }
    
    // Shuffle the questions
    generatedQuestions.shuffle()

    // Get random questions up to the amount specified by difficulty and
    // remove already added ones so no duplicates are found
    for _ in 1...selectedDifficulty.questions {
      let randomQuestion = generatedQuestions.randomElement()
      ?? Question(leftOperand: .zero, rightOperand: .zero)
      questions.append(randomQuestion)
      
      if let index = generatedQuestions.firstIndex(
        where: { $0.id == randomQuestion.id }
      ) {
        generatedQuestions.remove(at: index)
      }
    }
    
    return questions
  }
  
  private func addRoundResultsToScoreboardFrom(correctAnswers: Int) {
    let round = GameRound(
      correctAnswers: correctAnswers,
      difficulty: selectedDifficulty
    )
    
    scoreBoard.rounds.insert(round, at: 0)
  }
}

struct HomeScreen_Previews: PreviewProvider {
  static var previews: some View {
    HomeScreen()
      .environmentObject(ScoreBoard())
  }
}
