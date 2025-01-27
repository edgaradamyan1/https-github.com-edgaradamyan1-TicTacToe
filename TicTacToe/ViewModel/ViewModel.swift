//
//  ViewModel.swift
//  TicTacToe
//
//  Created by Edgar Adamyan on 27.01.25.
//
import SwiftUI

class GameViewModel: ObservableObject {
  @Published var game: Game
  @Published var message: String = ""
  @Published var isGameOver: Bool
  @Published var countText: String = ""
  
  init() {
    let player1 = Player(name: "Player 1", symbol: "X", color: .blue , image: "player1", count: 0)
    let player2 = Player(name: "Player 2", symbol: "O", color: .red, image: "player2", count: 0)
    
    self.game = Game(
      board: Array(repeating: Array(repeating: nil, count: 3), count: 3),
      players: [player1, player2],
      currentPlayer: player1
    )
    self.isGameOver = false
  }

  func makeMove(row: Int, column: Int) {
    
    if isGameOver || game.board[row][column] != nil {
      return
    }
    
    if game.makeMove(row: row, column: column) {
      if let winner = game.checkWinner() {
        isGameOver = true
        if let index = game.players.firstIndex(where: {$0.name == winner.name}) {
          game.players[index].count += 1
          countText = "\(game.players[index].name): \(game.players[index].count)"
        }
        message = "\(winner.name) has won!"
      
      } else if game.checkTie() {
        isGameOver = true
        message = "Its tie!"
      }else {
        game.switchPlayer()
      }
    }
  }
  
  func resetGame() {
    game.resetGame()
    isGameOver = false
    message = ""
  }
}


