//
//  Question.swift
//  TimesTables
//
//  Created by Zaid Neurothrone on 2022-10-05.
//

import Foundation

final class Question: Identifiable {
  let id = UUID().uuidString
  let leftOperand: Int
  let rightOperand: Int
  var wasAnsweredCorrectly: Bool? = nil
  
  init(leftOperand: Int, rightOperand: Int) {
    self.leftOperand = leftOperand
    self.rightOperand = rightOperand
  }
  
  var answer: Int {
    leftOperand * rightOperand
  }
  
  func answerQuestion(_ answer: Int) {
    print("Was correct: \(answer == (leftOperand * rightOperand))")
    wasAnsweredCorrectly = answer == (leftOperand * rightOperand)
  }
}

extension Question: Equatable {
  static func ==(lhs: Question, rhs: Question) -> Bool {
    lhs.id == rhs.id
  }
}

