--tik tak toe app in terminal


-- declare 3d board
local board = {
    {1, 2, 3},
    {4, 5, 6},
    {7, 8, 9}
}

--runtime variables

local run = true

local turn = true


--function to loop through 3d board and compile a user-friendly visual map of board
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


--used by checkWin() function(see below) to check for all possible win positions for both "X" and "O" 
local function checkMatches(XO)


    if XO == "X" then

        for i, v in pairs(board) do

            if board[i][1] == "X" and board[i][2] == "X" and board[i][3] == "X" then 
                return "xTrue"
            end
        end

        if board[1][1] == "X" and board[2][2] == "X" and board[3][3] == "X" then
            return "xTrue"
        end
        if board[1][3] == "X" and board[2][2] == "X" and board[3][1] == "X" then
            return 'xTrue'
        end
    else
        for i, v in pairs(board) do

            if board[i][1] == "O" and board[i][2] == "O" and board[i][3] == "O" then 
                return "otrue"
            end
        end

        if board[1][1] == "O" and board[2][2] == "O" and board[3][3] == "O" then
            return "otrue"
        end
        if board[1][3] == "O" and board[2][2] == "O" and board[3][1] == "O" then
            return "otrue"
        end

    end


end


-- uses checkMatches() function(see above) to determine a winner. This function is called by the game loop after every computer and player turn
local function checkWin()

    local result = nil

    if turn then
        result = checkMatches("O")

    else
        reslut = checkMatches("X")
    end

    if reslut == "xTrue" then

        io.write("Player wins!")
        os.exit()
    end

    if reslut == "oTrue" then

        io.write("Computer wins!")
        os.exit()
    end

end 






--function to allow user to move if all criteria is met(must be players turn and must be open spot)
local function playerMove()

    if turn then

        io.write("Player, its your turn, choose a spot(1-9) to put your X: ")
        io.flush()
        local answer = tonumber(io.read())

        
        
        if answer <= 3 then
            if board[1][answer] ~= "X" and board[1][answer] ~= "O" then
                board[1][answer] = "X"
                printBoard()
                turn = false
                
            else
                io.write("Cannot place X on other mark!")
                io.write("\n")
                playerMove()
            end
        end
        if answer <= 6 and answer > 3 then
            if board[2][answer - 3] ~= "X" and board[2][answer - 3] ~= "O" then
                board[2][answer - 3] = "X"
                printBoard()
                turn = false
                
            else
                io.write("Cannot place X on other mark!")
                io.write("\n")
                playerMove()
            end
        end
        if answer <= 9 and answer > 6 then
            if board[3][answer - 6] ~= "X" and board[3][answer - 6] ~= "O" then
                board[3][answer - 6] = "X"
                printBoard()
                turn = false
                
            else
                io.write("Cannot place X on other mark!")
                io.write("\n")
                playerMove()
            end
            
        end
    end
end
-- function to allow computer to make a randomly generated move if it meets criteria(must be NOT player turn and must be open space)
local function cMove()

    if turn == false then

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
            io.write("\n")
            turn = true
            

        else
            
            cMove()
        end


    end

end
--game loop to run all functions and facilitate gameplay
while run do
    printBoard()
    playerMove()
    checkWin()
    cMove()
    checkWin()

end



--end