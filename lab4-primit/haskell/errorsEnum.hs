module Main where -- similar to Java main method

import System.IO (hSetBuffering, stdout, BufferMode(..))

main =
    do
    initialiseIO
    putStrLn ("known errors = " ++ show allErrors)
    error <- getElement "error" -- java equivalent of : Error error = getElement("error");
    putStrLn (show error ++ " results in: " ++ show (error2Result error))
    
initialiseIO =
    do
    hSetBuffering stdout NoBuffering
        -- ensure any console output is shown asap

data Error = FP_Rounding | FP_Overflow | FP_Underflow | Int_Overflow -- enum 
    deriving (Show, -- default formatting
              Read, -- default parsing
              Eq,   -- default equality testing
              Bounded, -- default minBound and maxBound
              Enum) -- default sequencing (needed for .. ranges)
data Result = Zero | Infinity | ABitDifferent | VeryDifferent
    deriving (Show, -- default formatting
              Read, -- default parsing
              Eq,   -- default equality testing
              Bounded, -- default minBound and maxBound
              Enum) -- default sequencing (needed for .. ranges)

allErrors :: [Error] -- ie it is a list of PL elements
allErrors = [minBound .. maxBound]

-- similar to Java's switch
error2Result FP_Rounding = ABitDifferent
error2Result FP_Overflow = Infinity
error2Result FP_Underflow = Zero
error2Result Int_Overflow = VeryDifferent

-- The code below should not be changed and does not need to be fully understood.

{-
  `getElement'
  queries the user for one element until the user types something 
  that can be interpreted as the correct type of element (eg integer)
-}
getElement elementTypeName =
    do
    hSetBuffering stdout NoBuffering -- print to console in real time, not in batches
    putStr ("Input one " ++ elementTypeName ++ ": ") -- print the prompt
    line <- getLine -- get whatever user types as a string
    case parseElement line of
         Just element -> 
            do
            return element
         Nothing -> 
            do -- replaces java null and is much safer
            putStrLn ("Invalid " ++ elementTypeName ++ ", try again")
            getElement elementTypeName -- try again - using recursion

parseElement line =
    case reads line of -- parsing 
        [] -> -- no valid interpretation of the line as an element ([] = the empty list) -> if the parsing fails
            Nothing
        -- [pattern 2:]
        ((e,_) : _) -> -- found at least one interpretation, call it "e"
            Just e -- type of e is derived from context
                   -- where getElement is used
