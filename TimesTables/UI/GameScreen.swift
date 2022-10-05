//
//  GameScreen.swift
//  TimesTables
//
//  Created by Zaid Neurothrone on 2022-10-05.
//

import SwiftUI

struct GameScreen: View {
  @Environment(\.dismiss) private var dismiss
  
  @FocusState private var isAnswerFocused: Bool
  
  @State private var answer = ""
  @State private var currentQuestion: Question? = nil
  @State var questions: [Question]
  
  let onDonePlaying: (_ correctAnswers: Int) -> Void
  
  var body: some View {
    content
      .navigationTitle("Game")
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("End Game", action: endGame)
            .buttonStyle(.borderedProminent)
            .tint(.purple)
        }
        
        ToolbarItemGroup(placement: .keyboard) {
          Button("Dismiss") { isAnswerFocused = false }
          Spacer()
          Button("Done") {
            if let index = questions.firstIndex(where: { $0 == currentQuestion }) {
              questions[index].answerQuestion(Int(answer) ?? .zero)
              self.currentQuestion = nil
            }
          }
        }
      }
  }
  
  @ViewBuilder
  var content: some View {
    if questions.isEmpty {
      Text("No questions")
    } else {
      List {
        ForEach(questions) { question in
          VStack {
            HStack {
              Text("What is \(question.leftOperand) x \(question.rightOperand)?")
              Spacer()
              
              if let wasCorrect = question.wasAnsweredCorrectly {
                Image(systemName: wasCorrect ? "checkmark" : "xmark")
                  .foregroundColor(wasCorrect ? .green : .red)
              }
              
              Button {
                currentQuestion = question
                answer = ""
                isAnswerFocused = true
              } label: {
                Image(systemName: "keyboard")
                  .font(.largeTitle)
                  .tint(.purple)
              }
              .disabled(question.wasAnsweredCorrectly != nil)
            }
            
            if let currentQuestion, currentQuestion == question {
              TextField("Answer", text: $answer)
                .focused($isAnswerFocused)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .keyboardType(.numberPad)
            }
          }
        }
      }
    }
  }
}

extension GameScreen {
  private func endGame() {
    let correctAnswers = questions.reduce(0) { partialResult, question in
      if let wasAnsweredCorrectly = question.wasAnsweredCorrectly, wasAnsweredCorrectly {
        return partialResult + 1
      }
      return partialResult
    }
    
    onDonePlaying(correctAnswers)
    dismiss()
  }
}

struct GameScreen_Previews: PreviewProvider {
  static var previews: some View {
    GameScreen(questions: Question.Preview.samples, onDonePlaying: { _ in })
  }
}
