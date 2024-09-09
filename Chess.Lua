-- 駒の初期設定
local board = {
    {'R', 'H', 'C', 'K', 'Q', 'C', 'H', 'R'},
    {'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'},
    {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
    {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
    {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
    {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
    {'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'},
    {'r', 'h', 'c', 'k', 'q', 'c', 'h', 'r'}
}

--チェスボード
local function displayBoard()
    io.write("     a   b   c   d   e   f   g   h\n")
    io.write("   " .. string.rep("----", 8) .. "\n")
    for i = 8, 1, -1 do
        io.write(i .. " ")
        for j = 1, 8 do
            io.write(" | " .. board[i][j])
        end
        io.write(" | " .. i .. "\n")
        io.write("   " .. string.rep("----", 8) .. "\n")
    end
    io.write("     a   b   c   d   e   f   g   h\n")
end

--チェスの駒がボードの有効な位置にあるかどうかを確認する。
local function isValidPosition(row, col)
    return row >= 1 and row <= 8 and col >= 1 and col <= 8
end

--プレイヤーが駒を移動させるときにこの関数を呼び出して、ボードの更新を行う。
local function movePiece(fromRow, fromCol, toRow, toCol)
    if not isValidPosition(fromRow, fromCol) or not isValidPosition(toRow, toCol) then
        print("Invalid move.")
        return false
    end
    board[toRow][toCol] = board[fromRow][fromCol]
    board[fromRow][fromCol] = ' '
    return true
end

--プレイヤーに次の手を入力させ、その入力を解析して駒の移動を処理する。
local function getPlayerMove()
    io.write("\n")
    io.write("Enter move (e.g., 'e2 e4'): ")
    local move = io.read()
    local fromCol, fromRow, toCol, toRow = move:match("(%a)(%d) (%a)(%d)")
    if fromCol and fromRow and toCol and toRow then
        fromCol = string.byte(fromCol) - string.byte('a') + 1
        fromRow = tonumber(fromRow)
        toCol = string.byte(toCol) - string.byte('a') + 1
        toRow = tonumber(toRow)
        return fromRow, fromCol, toRow, toCol
    else
        print("Invalid input format.")
        return nil
    end
end

--ゲームを開始し、無限ループでプレイヤーの入力を処理し続ける。
local function game_play()
    print("WELCOME TO LUA CHESS GAME\n")
    local turn = 0
    while true do
        displayBoard()
        local fromRow, fromCol, toRow, toCol = getPlayerMove()
        if fromRow and fromCol and toRow and toCol then
            if movePiece(fromRow, fromCol, toRow, toCol) then
                turn = (turn + 1) % 2
                print("Player " .. (turn + 1) .. "'s turn")
            end
        end
    end
end

game_play()
