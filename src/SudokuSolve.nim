# Sudoku Solver in Nim
# Seiichi Ariga <seiichi.ariga@gmail.com>

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

# 盤面の表示用
proc printBoard(board: Board) =
  for i in 0..<Size:
    if i mod 3 == 0 and i != 0: echo "------+-------+------"
    for j in 0..<Size:
      if j mod 3 == 0 and j != 0: stdout.write "| "
      stdout.write $board[i][j] & " "
    echo ""

# --- 実行例 ---
var sudoku: Board = [
  [5, 3, 0, 0, 7, 0, 0, 0, 0],
  [6, 0, 0, 1, 9, 5, 0, 0, 0],
  [0, 9, 8, 0, 0, 0, 0, 6, 0],
  [8, 0, 0, 0, 6, 0, 0, 0, 3],
  [4, 0, 0, 8, 0, 3, 0, 0, 1],
  [7, 0, 0, 0, 2, 0, 0, 0, 6],
  [0, 6, 0, 0, 0, 0, 2, 8, 0],
  [0, 0, 0, 4, 1, 9, 0, 0, 5],
  [0, 0, 0, 0, 8, 0, 0, 7, 9]
]

if solve(sudoku):
  printBoard(sudoku)
else:
  echo "解が見つかりませんでした。"