-- |
-- Module         :  Proj1
-- Author 	      :  Ding Wang 
-- Student Number :  722822
-- Login Name     :  dingw2
-- Purpose        :  build all pitches with 3 chords
-- 
-- This file is uesd to build all the pitches
module Pitches (buildChords, allPitches) where

{- |
 - List all notes and octaves
-}

note = ["A","B","C","D","E","F","G"]  
ocatve = ["1","2","3"]

{- |
 - Build chords 
-}
buildChords :: [String]
buildChords = [x ++ y|x <- note, y <- ocatve]

{- |
 - Build all possible 3-pitches
-}
allPitches :: [[String]]
allPitches =  [[x,y,z]| x <- buildChords, y <- [ a|a<-buildChords, a>x], z <-[ b | b<-buildChords, b>y]]