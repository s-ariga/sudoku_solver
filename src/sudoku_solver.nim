# A simple Sudoku Solver in Nim, using backtracking.
# Seiichi Ariga <seiichi.ariga@gmail.com>

import os, strutils

const Size = 9

type Board = array[Size, array[Size, int]]

# 指定した数字がその位置に置けるかチェック
proc isValid(board: Board, row, col, num: int): bool =
  for i in 0..<Size:
    # 行、列、3x3ブロックの重複をチェック
    if board[row][i] == num or board[i][col] == num:
      return false
    
    let boxRow = 3 * (row div 3) + (i div 3)
    let boxCol = 3 * (col div 3) + (i mod 3)
    if board[boxRow][boxCol] == num:
      return false
  return true

# バックトラッキングによる解決
proc solve(board: var Board): bool =
  for r in 0..<Size:
    for c in 0..<Size:
      if board[r][c] == 0: # 空いているマスを探す
        for num in 1..9:
          if isValid(board, r, c, num):
            board[r][c] = num
            if solve(board): return true # 次のマスへ
            board[r][c] = 0 # 失敗したら戻す
        return false # 1-9のどれも入らなければ失敗
  return true # 全てのマスが埋まった

# 盤面の表示
proc printBoard(board: Board) =
  for i in 0..<Size:
    if i mod 3 == 0 and i != 0: echo "------+-------+------"
    for j in 0..<Size:
      if j mod 3 == 0 and j != 0: stdout.write "| "
      stdout.write $board[i][j] & " "
    echo ""

proc parseBoard(input: string): Board =
  ## 81文字の(整数)文字列をBoard型に変換する
  var b: Board
  if input.len != 81:
    raise newException(ValueError, "入力は81文字の半角である必要があります")
  
  for i, c in input:
    let val = ord(c)-ord('0')
    if val < 0 or val > 9:
      raise newException(ValueError, "0-9の数字のみ入力可能です")
    b[i div 9][i mod 9] = val
  return b
    
proc toString(board: Board): string = 
  ## int配列Boardを数独盤面に対応する文字列にする
  result = ""
  for r in 0..<Size:
    for c in 0..<Size:
      result.add($board[r][c])

# --- 実行例 ---
var sudoku: Board = [
  [0,0,2,4,0,0,0,0,0],
  [0,6,0,0,0,7,1,0,0],
  [0,3,0,0,0,0,0,8,0],
  [0,0,9,5,0,0,0,0,2],
  [5,0,0,0,0,0,0,0,4],
  [8,0,0,0,0,2,7,0,0],
  [0,4,0,0,0,0,0,9,0],
  [0,0,5,8,0,0,0,7,0],
  [0,0,0,0,0,3,6,0,0]
] # JNPC2014の問題で初期化

# if solve(sudoku):
#   printBoard(sudoku)
# else:
#   echo "解が見つかりませんでした。"

if isMainModule: 
  let args = commandLineParams()
  if args.len > 0:
    try:
      sudoku = parseBoard(args[0])
    except ValueError as e:
      echo "入力エラー: ", e.msg
      echo "Usage: ./sudoku_solver <81文字の半角数字>"
      quit(1)
  
  echo "問題:"
  sudoku.printBoard()
  if solve(sudoku):
    echo "解答:"
    sudoku.printBoard()
  else:
    echo "解が見つかりませんでした"
