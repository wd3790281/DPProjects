-- |
-- Module         :  Proj1
-- Author 	      :  Ding Wang 
-- Student Number :  722822
-- Login Name     :  dingw2
-- Purpose        :  optimize the next guess
-- 
-- This is used to choose the best guess from the possible pitches

module OptimalGuess(bestGuess, computeFbNum, compairFbNum) where


import Data.List
import ComputeAns
import ChangeGameState


{- |
 - pick the first pitch that has the least different feedbacks.
-}
bestGuess :: [[String]] -> [String]
bestGuess pre = foldl (\acc x -> if compairFbNum pre acc x then acc else x) (head pre) pre

{- |
 - This function is used to compute how many different feedbacks it can get if a pitch is 
 - picked as the next
-}

computeFbNum :: [[String]] -> [String] -> Int
computeFbNum g c = length $ group $ sort $ computeAllAns g c

{- |
 - Compair the different feedbacks number of two candidates, reture true if the former on 
 - get most different feedbacks in next guess
-}

compairFbNum :: [[String]] -> [String] -> [String] -> Bool
compairFbNum v m n
	| computeFbNum v m > computeFbNum v n  = True
	| otherwise   = False

