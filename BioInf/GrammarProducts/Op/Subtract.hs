{-# LANGUAGE FlexibleInstances #-}

module BioInf.GrammarProducts.Op.Subtract where

import Control.Newtype
import Data.Semigroup
import Control.Lens
import Control.Lens.Fold
import qualified Data.Set as S
import Data.List (genericReplicate)
import Text.Printf

import BioInf.GrammarProducts.Grammar
import BioInf.GrammarProducts.Helper



-- | Subtract two grammars. Implemented as the union of production rules without any
-- renaming.

newtype Subtract a = Subtract {unSubtract :: a}



instance Semigroup (Subtract Grammar) where
  (Subtract l) <> (Subtract r)
    | dl /= dr  = error $ printf "grammars %s and %s have different dimensions, cannot unify."
    | otherwise = Subtract $ Grammar xs (l^.gname ++ "," ++ r^.gname)
    where
      dl = gD $ l^.ps
      dr = gD $ r^.ps
      gD = head . map (^.lhs.to head.dim) . S.toList
      xs = (l^.ps) S.\\ (r^.ps)
