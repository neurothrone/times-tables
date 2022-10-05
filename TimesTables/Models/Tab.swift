//
//  Tab.swift
//  TimesTables
//
//  Created by Zaid Neurothrone on 2022-10-05.
//

import Foundation

enum Tab: String {
  case home
  case scoreboard
}

extension Tab: Identifiable, CaseIterable {
  var id: Self { self }
}
