--tik tac toe app in terminal


-- declare 2d board
local board = {
    {1, 2, 3},
    {4, 5, 6},
    {7, 8, 9}
}
--template board for computer user interface
local templateBoard = {
    {1, 2, 3},
    {4, 5, 6},
    {7, 8, 9}
}

--runtime variables

local run = true

local turn = true

local continue = false


--function to loop through 2d board and compile a user-friendly visual map of board
local function printBoard() 

    for i, v in pairs(board) do 
        
        for j, k in pairs(v) do 
            io.write(board[i][j])
            if j == 1 or j == 2 then
                io.write(" | ")
            else

            end
            
        end
        if i == 1 or i == 2 then
            io.write("\n")
            io.write("----------")
            io.write("\n")
        else
            io.write("\n")
            io.write("\n")
        end
    end
end
-- not currently used, resets 2d board
local function resetBoard()
    board = {
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 9}
    }
end
--used by checkWin() function(see below) to check for all possible win positions for both "X" and "O"
--posible 0.5x optimization to condense "X" and "O" piece into 1 statment
local function checkMatches(XO)

    --check if function is called to check for "X" or "O" peice on board
    if XO == "X" then
        --this part of the if statment is for "X" piece specifically, refer below for "O" piece

        --loops through board to check for horizontal wins
        for i, v in pairs(board) do

            if board[i][1] == "X" and board[i][2] == "X" and board[i][3] == "X" then 
                return "xTrue"
            end
        end
        --end
        --Checks for vertical wins(not optimized, loop???)
        if board[1][1] == "X" and board[2][1] == "X" and board[3][1] == "X" then
            return "xTrue"
        end
        if board[1][2] == "X" and board[2][2] == "X" and board[3][2] == "X" then
            return "xTrue"
        end
        if board[1][3] == "X" and board[2][3] == "X" and board[3][3] == "X" then
            return "xTrue"
        end
        -- end
        --checks for diagonal wins(loop probably not necessary)
        if board[1][1] == "X" and board[2][2] == "X" and board[3][3] == "X" then
            return "xTrue"
        end
        if board[1][3] == "X" and board[2][2] == "X" and board[3][1] == "X" then
            return 'xTrue'
        end
        --end
    else
        --counterpart code for "O" peices, refer above for documentation
        for i, v in pairs(board) do

            if board[i][1] == "O" and board[i][2] == "O" and board[i][3] == "O" then 
                return "oTrue"
            end
        end

        if board[1][1] == "O" and board[2][1] == "O" and board[3][1] == "O" then
            return "oTrue"
        end
        if board[1][2] == "O" and board[2][2] == "O" and board[3][2] == "O" then
            return "oTrue"
        end
        if board[1][3] == "O" and board[2][3] == "O" and board[3][3] == "O" then
            return "oTrue"
        end

        if board[1][1] == "O" and board[2][2] == "O" and board[3][3] == "O" then
            return "oTrue"
        end
        if board[1][3] == "O" and board[2][2] == "O" and board[3][1] == "O" then
            return "oTrue"
        end

    end


end
-- uses checkMatches() function(see above) to determine a winner. This function is called by the game loop after every computer and player turn
local function checkWin()

    local result = nil

    if turn then
        --becuase turn varible is switched after respective playerMove() and cMove() functions, logic is counterintuitive, must send oppisite of turn
        result = checkMatches("O")

    else
        result = checkMatches("X")
    end

    if result == "xTrue" then
        
        --feeble attempt to make a continuous game, needs work. Uses resetBoard() function (but only resets once for some reason???)
        io.write("\n")
        io.write("Player wins!")
        io.write("\n")
        io.write("\n")
        io.write("1 to restart, 2 to exit")
        io.flush()
        local answer = tonumber(io.read())
        if answer == 1 then
            resetBoard()
            continue = true
        else            
            os.exit()

        end

        
    end

    if result == "oTrue" then
        io.write("\n")
        io.write("Computer wins!")
        io.write("\n")
        io.write("\n")
        io.write("1 to restart, 2 to exit")
        io.flush()
        local answer = tonumber(io.read())
        if answer == 1 then
            resetBoard()
            continue = true
        else
            os.exit()

        end
    end

end 

--function to allow user to move if all criteria is met(must be players turn and must be open spot)
local function playerMove()

    if turn then

        io.write("Player, its your turn, choose a spot(1-9) to put your X: ")
        io.flush()
        local answer = tonumber(io.read())

        
        --Takes user input and makes it readable by 2d board - row 1
        --possible to do this by looping through board and seeing if slot text matches answer
        if answer <= 3 then
            if board[1][answer] ~= "X" and board[1][answer] ~= "O" then
                board[1][answer] = "X"
                
                turn = false
                
            else
                io.write("Cannot place X on other mark!")
                io.write("\n")
                playerMove()
            end
        end
        --Takes user input and makes it readable by 2d board - row 2
        if answer <= 6 and answer > 3 then
            if board[2][answer - 3] ~= "X" and board[2][answer - 3] ~= "O" then
                board[2][answer - 3] = "X"
                
                turn = false
                
            else
                io.write("Cannot place X on other mark!")
                io.write("\n")
                playerMove()
            end
        end
        --Takes user input and makes it readable by 2d board - row 3
        if answer <= 9 and answer > 6 then
            if board[3][answer - 6] ~= "X" and board[3][answer - 6] ~= "O" then
                board[3][answer - 6] = "X"
                
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
        local row = math.random(1, 3)
        local choice = math.random(1, 3)

        if board[row][choice] ~= "X" and board[row][choice] ~= "O" then
            board[row][choice] = "O"
            io.write("\n")
            io.write("Computer moved to slot: ".. templateBoard[row][choice])
            io.write("\n")
            io.write("\n")
            turn = true
            

        else
            
            cMove()
        end


    end

end
-- This function is called by the game loop to determine if the game should be ended due to neither player or computer winning
local function checkTie()
    local target = 9
    local counter = 0
    for i, v in pairs(board) do
        for j, k in pairs(v) do 
            if board[i][j] == "X" or board[i][j] == "O" then
                counter = counter + 1
            end
        end
    end

    if counter == target then
        
        io.write("Cat's game!")
        io.write("\n")
        os.exit()

    end

end
--game loop to run all functions and facilitate gameplay



local function gameLoop() 
    printBoard()
    
    playerMove()
    checkWin()
    
    cMove()
    checkWin()
    
    
end
--runs gameloop while run condition == true
while run do
    gameLoop()     
end








--end