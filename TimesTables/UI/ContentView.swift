//
//  ContentView.swift
//  TimesTables
//
//  Created by Zaid Neurothrone on 2022-10-05.
//

import SwiftUI

private extension Tab {
  @ViewBuilder
  var view: some View {
    switch self {
    case .home:
      HomeScreen()
    case .scoreboard:
      ScoreboardScreen()
    }
  }
}

struct ContentView: View {
  @State private var selectedTab: Tab = .home
  
  @StateObject private var scoreBoard: ScoreBoard = .init()

  var body: some View {
    NavigationStack {
      TabView(selection: $selectedTab) {
        ForEach(Tab.allCases) { tab in
          tab.view
            .environmentObject(scoreBoard)
            .padding()
            .tabItem {
              Label(tab.rawValue.capitalized, systemImage: "house")
            }
        }
      }
      .navigationTitle(selectedTab.rawValue.capitalized)
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
