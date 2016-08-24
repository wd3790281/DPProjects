-- |
-- Module         :  Proj1
-- Author 	      :  Ding Wang 
-- Student Number :  722822
-- Login Name     :  dingw2
-- Purpose        :  build and change game state
-- 
-- This is used to build and change game state
module ChangeGameState(computeAllAns,buildGameState,deleteState,takeNewChords,GameState) where

import ComputeAns

{- |
 - GameState is a associate list. Feedback is get from comparing associate pitch and the guess
 - All possible answer pitches and its feedback are stored as a pair in game state.
-}
type GameState = [(Feedback,[String])] 

{- |
 - Compute all the feedback in a feedback list if given the guess and all possible candidates with the order of 
 - the candidate. 
-}

computeAllAns :: [[String]] -> [String] -> [Feedback]
computeAllAns guessGroup guess = map (getFeedback guess) guessGroup

{- |
 - Build the game state according to the candidate and its feedback
-}
buildGameState :: [Feedback] -> [[String]] -> GameState
buildGameState newFb guessGroup = zip newFb guessGroup

{- |
 - delete the impossilbe pitches according to the response
-}

deleteState :: Feedback -> GameState -> GameState
deleteState response preGameState = filter (\(k,v) -> k == response) preGameState

{- |
 - seperate the new possible answers from the new possible game state pairs
-}
takeNewChords :: GameState -> [[String]]
takeNewChords state = b 
	where (a,b) = unzip state



