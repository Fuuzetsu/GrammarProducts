{-# LANGUAGE TemplateHaskell #-}

module BioInf.GrammarProducts.Grammar where

import Data.List.NonEmpty (NonEmpty)
import Data.Set (Set)
import Control.Lens
import Control.Lens.TH
import Data.List (genericReplicate)



data NTSym = NTSym
  { _name    :: String
  , _modulus :: Integer
  , _index   :: Integer
  }
  deriving (Show,Eq,Ord)

newtype TSym  = TSym  String
  deriving (Show,Eq,Ord)

data NtT
  = Nt
    { _dim  :: Integer
    , _symN :: [NTSym]
    , _guid :: Integer
    }
  | T
    { _dim  :: Integer
    , _symT :: [TSym]
    , _guid :: Integer
    }
  deriving (Show,Eq,Ord)

epsilonNtSym = NTSym "" 0 0

epsilonTSym  = TSym ""

epsilonNt :: Integer -> NtT
epsilonNt d = Nt d (genericReplicate d (NTSym "" 0 0)) 0

epsilonT :: Integer -> NtT
epsilonT d = T d (genericReplicate d (TSym "")) 0

isEpsilonNtSym = (==epsilonNtSym)

isEpsilonTSym  = (==epsilonTSym)

isEpsilon :: NtT -> Bool
isEpsilon (Nt d zs 0) = all isEpsilonNtSym zs
isEpsilon (T  d zs 0) = all isEpsilonTSym  zs

isNt (Nt{}) = True
isNt _      = False

isT = not . isNt

data PR = PR
  { _lhs :: [NtT]
  , _rhs :: [NtT]
  }
  deriving (Show,Eq,Ord)

data Grammar = Grammar
  { _ps    :: Set PR
  , _gname :: String
  }
  deriving (Show)

makeLenses ''Grammar
makeLenses ''PR
makeLenses ''NtT
makeLenses ''NTSym
