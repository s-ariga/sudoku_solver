# Seiichi Ariga <seiichi.ariga@gmail.com>

import unittest
import ../src/sudoku_solver

suite "数独ソルバーのテスト":

    test "isValidのチェック":
        var board: Board

        # (0,0)に5がある時、同じ行に5は置けない
        board[0][0] = 5
        check isValid(board, 0, 1, 5) == false

        # 別の行なら置ける
        check isValid(board, 1, 1, 5) == true

    test "簡単な問題が解けるか":
        var board: Board = [
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

    check solve(board) == true
    check board[0][2] == 4 # 最初の空きマスの正解