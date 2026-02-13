# Package

version       = "0.9.0"
author        = "Seiichi Ariga <seiichi.ariga@gmail.com>"
description   = "A simple Sudoku solver in Nim"
license       = "MIT"
srcDir        = "src"
bin           = @["sudoku_solver"]


# Dependencies

requires "nim >= 2.2.6"

task test, "Run the tests":
    exec "nim c -r tests/tsolver.nim"
