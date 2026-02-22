main = do
    putStrLn "Welcome to the programme. Please enter your name"
    name <- getLine
    putStrLn("Hello " ++ name ++ ", hope you like Haskell.")
    let result = onePlusone 1 1
    print ("1 + 1 = " ++ show result)
    

onePlusone a b = a + b