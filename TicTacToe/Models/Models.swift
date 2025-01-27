//
//  Models.swift
//  TicTacToe
//
//  Created by Edgar Adamyan on 27.01.25.
//

import SwiftUI

struct Player {
  let name: String
  let symbol: String
  let color: Color
  let image: String
  var count: Int
}

struct Game {
  var board: [[String?]]
  var players: [Player]
  var currentPlayer: Player
  let gridSize = 3
  
  mutating func resetGame() {
    board = Array(repeating: Array(repeating: nil, count: gridSize), count: gridSize)
    currentPlayer = players.first!
  }
  
  mutating func makeMove(row: Int, column: Int) -> Bool {
    if board[row][column] == nil {
      board[row][column] = currentPlayer.symbol
      return true
    }
    return false
  }
  
  mutating func switchPlayer() {
    if currentPlayer.symbol == players.first?.symbol {
      currentPlayer = players.last!
    } else {
      currentPlayer = players.first!
    }
  }
  
  mutating func checkWinner() -> Player? {
    for row in 0..<gridSize {
      if let symbol = board[row][0], symbol == board[row][1], symbol == board[row][2]  {
        return currentPlayer
      }
    }
    for column in 0..<gridSize {
      if let symbol = board[0][column], symbol == board[1][column], symbol == board[2][column] {
        return currentPlayer
      }
    }
    
    if let symbol = board[0][0], symbol == board[1][1], symbol == board[2][2] {
      
      return currentPlayer
    }
    if let symbol = board[2][0], symbol == board[1][1], symbol == board[0][2] {
      return currentPlayer
    }
    
    return nil
  }
  
  mutating func checkTie() -> Bool{
    for row in board {
      if row.contains(nil) {
        return false
      }
    }
    return checkWinner() == nil
  }
  
}
