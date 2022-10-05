//
//  MultiplicationTablesView.swift
//  TimesTables
//
//  Created by Zaid Neurothrone on 2022-10-05.
//

import SwiftUI

struct MultiplicationTablesView: View {
  @Binding var selectedNumber: Int

  private let multiplicationTables = [
    [2, 3, 4],
    [5, 6, 7],
    [8, 9, 10],
    [11, 12]
  ]
  
  var body: some View {
    Grid(alignment: .leading, horizontalSpacing: 25, verticalSpacing: 25) {
      ForEach(multiplicationTables, id: \.self) { row in
        GridRow {
          ForEach(row, id: \.self) { col in
            Button {
              selectedNumber = col
            } label: {
              Text(col.description)
                .frame(width: 44, height: 44)
            }
            .buttonStyle(.borderedProminent)
            .foregroundColor(selectedNumber != col ? .black : .primary)
            .tint(
              selectedNumber == col
              ? .purple
              : .purple.opacity(0.5)
            )
          }
        }
      }
    }
  }
}

struct MultiplicationTablesView_Previews: PreviewProvider {
  static var previews: some View {
    MultiplicationTablesView(selectedNumber: .constant(7))
  }
}
