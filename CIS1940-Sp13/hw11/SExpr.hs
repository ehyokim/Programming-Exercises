{- CIS 194 HW 11
   due Monday, 8 April
-}

module SExpr where

import AParser
import Control.Applicative
import Data.Char

------------------------------------------------------------
--  1. Parsing repetitions
------------------------------------------------------------

zeroOrMore :: Parser a -> Parser [a]
zeroOrMore p = oneOrMore p <|> pure []

oneOrMore :: Parser a -> Parser [a]
oneOrMore p = liftA2 (++) (sing <$> p) (zeroOrMore p <|> pure [])

sing :: a -> [a]
sing x = [x]

------------------------------------------------------------
--  2. Utilities
------------------------------------------------------------

spaces :: Parser String
spaces = zeroOrMore (satisfy isSpace)

ident :: Parser String
ident = liftA2 (++) (sing <$> satisfy isAlpha) (zeroOrMore (satisfy isAlphaNum))

------------------------------------------------------------
--  3. Parsing S-expressions
------------------------------------------------------------

-- An "identifier" is represented as just a String; however, only
-- those Strings consisting of a letter followed by any number of
-- letters and digits are valid identifiers.
type Ident = String

-- An "atom" is either an integer value or an identifier.
data Atom = N Integer | I Ident
  deriving Show

-- An S-expression is either an atom, or a list of S-expressions.
data SExpr = A Atom
           | Comb [SExpr]
  deriving Show

parseSExpr :: Parser SExpr
parseSExpr = parseNextAtom <|> parseNextOpenPara

-- mutually recursive. 
parseNextOpenPara :: Parser SExpr
parseNextOpenPara = spaces *> char '(' *> parseListSExpr 

parseNextClosePara :: Parser Char
parseNextClosePara = spaces *> char ')'

parseNextIdent :: Parser Atom
parseNextIdent = I <$> (spaces *> ident)

parseNextInt :: Parser Atom
parseNextInt = N <$> (spaces *> posInt)

parseNextAtom :: Parser SExpr
parseNextAtom = A <$> (parseNextInt <|> parseNextIdent) 

parseListSExpr :: Parser SExpr 
parseListSExpr = Comb <$> zeroOrMore (parseNextAtom <|> parseNextOpenPara) <* parseNextClosePara