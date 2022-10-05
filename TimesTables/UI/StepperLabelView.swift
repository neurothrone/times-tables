//
//  StepperLabelView.swift
//  TimesTables
//
//  Created by Zaid Neurothrone on 2022-10-05.
//

import SwiftUI

struct StepperLabelView: View {
  let text: String
  let value: Int
  
  var body: some View {
    HStack {
      Text(text)
      Spacer()
      Text(value.description)
        .bold()
        .padding(.trailing)
    }
  }
}

struct StepperLabelView_Previews: PreviewProvider {
  static var previews: some View {
    StepperLabelView(text: "Min Number:", value: 5)
  }
}
