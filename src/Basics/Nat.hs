----------------------------------------------------------------------
-- Copyright: 2013, Jan Stolarek, Lodz University of Technology     --
--                                                                  --
-- License: See LICENSE file in root of the repo                    --
-- Repo address: https://github.com/jstolarek/dep-typed-wbl-heaps   --
--                                                                  --
-- Definition of natural numbers and operations on them.            --
----------------------------------------------------------------------

{-# LANGUAGE DataKinds            #-}
{-# LANGUAGE GADTs                #-}
{-# LANGUAGE KindSignatures       #-}
{-# LANGUAGE NoImplicitPrelude    #-}
{-# LANGUAGE ScopedTypeVariables  #-}
{-# LANGUAGE TemplateHaskell      #-}
{-# LANGUAGE TypeFamilies         #-}
{-# LANGUAGE TypeOperators        #-}
{-# LANGUAGE UndecidableInstances #-}
module Basics.Nat where

import Data.Singletons.TH

import Basics.Bool

-- Nat represents natural numbers (starting with 0)
data Nat :: * where
  Zero :: Nat
  Succ :: Nat -> Nat

$(genSingletons [ ''Nat ])

-- We define some natural numbers as they will be useful later on
zero :: Nat
zero = Zero

sZero :: Sing Zero
sZero = SZero

$(singletons [d|
 one, two, three, four, five :: Nat
 one   = Succ Zero
 two   = Succ one
 three = Succ two
 four  = Succ three
 five  = Succ four

 -- Addition
 (+) :: Nat -> Nat -> Nat
 Zero     + m = m
 (Succ n) + m = Succ (n + m)
 |])

infix 6 +, %:+

-- Comparisons
(<) :: Nat -> Nat -> Bool
_ < Zero = False
Zero < Succ _ = True
Succ n < Succ m = n < m

(>=) :: Nat -> Nat -> Bool
_ >= Zero = True
Zero >= Succ _ = False
Succ m >= Succ n = m >= n

infixl 4 <, >=
