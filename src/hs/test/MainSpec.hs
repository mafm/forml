
module MainSpec where

import System.IO.Silently

import Control.Exception

import Data.ByteString (pack)
import Data.Char (ord)

import Test.Hspec
import Test.Hspec.HUnit
import Test.Hspec.QuickCheck (prop)

import Test.HUnit
import Test.QuickCheck hiding ((.&.), output)

import Forml.Exec
import Forml.CLI

spec = do

    describe "Forml Compiler" $ do
        it "should compile the prelude.forml & the tests suite" $ do
          (std_out, output) <- capture $ try (main' test_config)
          case (output :: Either SomeException ()) of 
            Left x -> assertFailure $
                          "\nException during compilation\n\n"
                          ++ show x
                          ++ "\n\nResults: (" ++ (show $ length std_out)
                          ++ " chars):\n\n" ++ std_out
            Right _ ->
                 if length std_out > 1860 && length std_out < 1920
                   then return ()
                   else assertFailure $
                          "\nResults: (" ++ (show $ length std_out)
                           ++ " chars):\n\n" ++ std_out

src_files :: [[Char]]
src_files = [ "src/forml/prelude.forml"
            , "src/forml/tests.forml"
            , "src/forml/readme.forml"
            , "src/forml/tetris.forml"  ]

test_config :: RunConfig
test_config =

    RunConfig { inputs = src_files
              , output = "default.js"
              , show_types = False
              , optimize   = True
              , silent     = False
              , flush      = False
              , run_tests  = Phantom
              , write_docs = True
              , implicit_prelude = False
              , remote     = True
              , watch      = False }


