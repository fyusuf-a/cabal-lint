{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import System.Process.Typed
import System.Directory
import System.Exit (exitSuccess)
import Text.Regex.Posix
import Data.Text (Text)
import qualified Data.Text.IO as T
import Data.Text.Encoding (decodeUtf8, encodeUtf8)
import Data.ByteString.Lazy (toStrict, ByteString)
import Control.Exception (catch)

second :: Int -> Text -> IO ()
second 0 _ = return ()
second n "" = do
      (_, str) <- readProcessInterleaved $ proc "cabal" ["new-build"]
      second n (decodeUtf8 . toStrict $ str)
second n str
  | encodeUtf8 str =~ ("Up to date" :: ByteString) = do
      previous <- catch (readFile ".cabal-lint") $ \(_ :: IOError) -> do
        runProcess_ $ proc "cabal" ["clean"]
        second n ""
        exitSuccess
      putStrLn previous
  | encodeUtf8 str =~ ("No cabal.project file" :: ByteString) = do
      setCurrentDirectory ".."
      second (n - 1) ""
  | otherwise = do
      T.writeFile ".cabal-lint" str
      T.putStrLn str
  
main :: IO ()
main = do
  path <- getCurrentDirectory
  second (1 + length (filter (=='/') path)) ""
