-- |
-- Module         :  Proj1
-- Author 	      :  Ding Wang 
-- Student Number :  722822
-- Login Name     :  dingw2
-- Purpose        :  to compute feedback
-- 
-- This is used to compute feedback
module ComputeAns(getNote,getOctave,countDifNote,countDifOctave,countCom,getFeedback,Feedback) where

import Pitches
import Data.Char
import Data.List
type Feedback = (Int, Int, Int) 

{- |
 - sperate the note from chords
-}
getNote :: [String] -> String
getNote target = filter (isAlpha) $ concat target

{- |
 - sperate the octave from chords
-}
getOctave :: [String] -> String
getOctave target = filter (isDigit) $ concat target

{- |
 - count the number of different note between two 3-pitches
-}
countDifNote :: [String] -> [String] -> Int
countDifNote guess target = length $ (getNote guess) \\ (getNote target) 

{- |
 - count the number of different octaves between two pitches
-}
countDifOctave :: [String] -> [String] -> Int
countDifOctave guess target = length $ (getOctave guess) \\ (getOctave target) 

{- |
 - count the same chords in the two pitches
-}
countCom :: [String] -> [String] -> Int
countCom c1 c2 = length $ intersect c1 c2

{- |
 - generate the my feedback according to the function above
 - when computing the right note, we should remove the part has been counted in 
 - right part.
-}
getFeedback :: [String] -> [String] -> Feedback
getFeedback chord target = (right, rightNote, rightOctave)
  where right = countCom chord target
        rightNote = 3 - countDifNote chord target - right 
        rightOctave = 3 -  countDifOctave chord target - right