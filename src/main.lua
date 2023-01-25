--tik tak toe app in terminal

local board = {
    {1, 2, 3},
    {4, 5, 6},
    {7, 8, 9}
}

local turn = true

local function printBoard() 

    for i, v in pairs(board) do 
        
        for j, k in pairs(v) do 
            io.write(board[i][j])
            if j == 1 or j == 2 then
                io.write("|")
            else

            end
            
        end
        if i == 1 or i == 2 then
            io.write("\n")
            io.write("-----")
            io.write("\n")
        else
            io.write("\n")
        end
    end
end

local function checkWin(XO)

end

local function playerMove()

    if turn then

        io.write("Player, its your turn, choose a spot(1-9) to put your X: ")
        io.flush()
        local answer = tonumber(io.read())

        
        
        if answer <= 3 then
            if board[1][answer] ~= "X" and board[1][answer] ~= "O" then
                board[1][answer] = "X"
                printBoard()
                playerMove = false
                if checkWin("X") then
                    io.write("You win!")
                end
            else
                io.write("Cannot place X on other mark!")
                playerMove()
            end
        end
        if answer <= 6 and answer > 3 then
            if board[2][answer - 3] ~= "X" and board[2][answer - 3] ~= "O" then
                board[2][answer - 3] = "X"
                printBoard()
                playerMove = false
                if checkWin("X") then
                    io.write("You win!")
                end
            else
                io.write("Cannot place X on other mark!")
                playerMove()
            end
        end
        if answer <= 9 and answer > 6 then
            if board[3][answer - 6] ~= "X" and board[3][answer - 6] ~= "O" then
                board[3][answer - 6] = "X"
                printBoard()
                playerMove = false
                if checkWin("X") then
                    io.write("You win!")
                end
            else
                io.write("Cannot place X on other mark!")
                playerMove()
            end
            
        end
    end
end

local function cMove()

    if playerMove == false then

        io.write("Calculating.")
        io.write("Calculating..")
        io.write("Calculating...")
        io.write("\n")
        

        local row = math.random(1, 3)
        local choice = math.random(1, 3)

        if board[row][choice] ~= "X" and board[row][choice] ~= "O" then
            board[row][choice] = "O"
            printBoard()
            io.write("Computer moved!")
            playerMove = true
            if checkWin("O") then
                io.write("Computer wins!")
            end

        else
            
            cMove()
        end


    end

end



printBoard()
playerMove()
cMove()

