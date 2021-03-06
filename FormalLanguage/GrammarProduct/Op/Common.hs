{-# LANGUAGE LambdaCase #-}

module FormalLanguage.GrammarProduct.Op.Common where

import qualified Data.Set as S
import Control.Lens

import FormalLanguage.CFG.Grammar



-- | Collect all terminal symbols from a set of rules.
--
-- TODO move to FormalGrammars library
--
-- TODO i guess, this collects multidim stuff for now!!!

collectTerminals :: S.Set Rule -> S.Set Symb
collectTerminals = S.fromList . filter isSymbT . concatMap _rhs . S.toList

-- | Collect all non-terminal symbols from a set of rules.
--
-- TODO move to FormalGrammars library

collectNonTerminals :: S.Set Rule -> S.Set Symb
collectNonTerminals = S.fromList . filter isSymbN . concatMap (\r -> r^.lhs : r^.rhs) . S.toList

collectEpsilons :: S.Set Rule -> S.Set TN
collectEpsilons = S.fromList
                . filter (\case E -> True ; z -> False)
                . concatMap (view symb)
                . concatMap _rhs
                . S.toList

genEps :: Symb -> [TN]
genEps s = replicate (length $ s^.symb) E

