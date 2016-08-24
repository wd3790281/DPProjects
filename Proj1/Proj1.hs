-- |
-- Module         :  Proj1
-- Author 	      :  Ding Wang 
-- Student Number :  722822
-- Login Name     :  dingw2
-- Purpose        :  give out the initial guess and next guess accroding to the feedback
-- 
-- This file contains the initial guess and next guess
module Proj1 (initialGuess, nextGuess, GameState) where


import Pitches
import OptimalGuess
import ChangeGameState
import ComputeAns

{- |
 - InitialGuess takes no arguments and returns a pair of an initial guess and the beginning game state
 - The initial game state is also a pair of feedback and all possible pitches. The feed back is compute
 - according to the innital guess.
-}
	
initialGuess :: ([String], GameState)
initialGuess =  (["A1","D2","G3"], buildGameState (computeAllAns allPitches ["A1","D2","G3"]) allPitches)


{- |
 - Next guess take the previous guess and game state and the feedback from main process as input
 - It will give out the next guess and the new game state according to the previous guess and game
 - state. 
 - newpossi is a list of pitches that can be the next guess according to the feedback
 - newGuess is the best one among newpossi
 - newfeedback is using newGuess to compute all the possible feedback can be in the remaining pitches
 - it will be stored at game state in order to find the next guess after this guess
 - new game state is build according to the new guess and the new feedback
-}
nextGuess :: ([String], GameState) -> Feedback -> ([String],GameState)
nextGuess (previouseGuess, state) feedback = (newGuess, newGameState)
     where filtedGuess = takeNewChords $ deleteState feedback state
     	   newGuess = bestGuess filtedGuess
     	   newfeedbcak = computeAllAns filtedGuess newGuess
     	   newGameState = buildGameState newfeedbcak filtedGuess



