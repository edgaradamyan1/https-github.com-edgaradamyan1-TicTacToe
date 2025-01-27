//
//  ContentView.swift
//  TicTacToe
//
//  Created by Edgar Adamyan on 27.01.25.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var viewModel = GameViewModel()
  var column = [
    GridItem(.fixed(100)),
    GridItem(.fixed(100)),
    GridItem(.fixed(100))
  ]
  
    var body: some View {
        VStack {
          title
          players
          message
          seperator
          gameBoard
          startGame
        }
    }
  
  var title: some View {
    Text("TIC TAC TOE")
      .font(.system(size: 60).bold())
      .shadow(radius: 30)
      .padding(.top)
  }
  
  var players: some View {
    HStack  {
      ForEach(viewModel.game.players, id: \.name) { player in
        VStack{
          Image(player.image)
            .padding(.horizontal, 70)
          Text(player.name)
            .font(.system(size: 25).bold())
          Text("Count: \(player.count) ")
        }
      }
    }
  }
  
  var message: some View {
    Text(viewModel.message)
      .fontWeight(.bold)
      .padding()
  }
  
  var seperator: some View {
    Rectangle()
      .frame(maxWidth: .infinity, maxHeight: 1)
      .padding(.bottom)
  }
  
  var gameBoard: some View {
    LazyVGrid(columns: column) {
      ForEach(0..<9, id: \.self) { index in
        let row = index / 3
        let column = index % 3

        Rectangle()
          .stroke(Color.black)
          .background(viewModel.game.board[row][column] == nil ? Color.white : Color.gray)
          .overlay(content: {
            Text(viewModel.game.board[row][column] ?? "")
              .font(.system(size: 50).bold())
              .foregroundStyle(viewModel.game.board[row][column] == "X" ? Color.red : Color.blue)
          })
          .onTapGesture {
            if !viewModel.isGameOver {
              viewModel.makeMove(row: row, column: column)
            }
          
          }
          .frame(height: 100)
      }
    }
    
  }
  
  var startGame: some View {
    Button {
      viewModel.resetGame()
    } label: {
      RoundedRectangle(cornerRadius: 20)
        .fill(Color.button)
        .frame(maxWidth: .infinity, maxHeight: 60)
        .padding()
        .overlay {
          Text("Start Game")
            .foregroundStyle(.black)
            .font(.system(size: 20).bold())
        }
    }

  }
}



#Preview {
    ContentView()
}
