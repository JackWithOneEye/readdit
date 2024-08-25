import GHC.IO.Handle (Handle, hGetLine, hIsEOF)
import GHC.IO.Handle.FD (withFile)
import GHC.IO.IOMode (IOMode (ReadMode))
import System.CPUTime (getCPUTime)
import System.Environment (getArgs)
import Text.Printf (printf)

parseArgs args = case args of
  ("--input" : inputFile : _) -> inputFile
  ("-i" : inputFile : _) -> inputFile
  _ -> error "input file path not given"

readdit :: Handle -> IO (Int, Int)
readdit file = do
  isEOF <- hIsEOF file
  readdit' file (0, 0) isEOF
  where
    readdit' _ result True = return result
    readdit' file (lines, chars) False = do
      line <- hGetLine file
      isEOF <- hIsEOF file
      readdit' file (lines + 1, chars + length line) isEOF

main = do
  start <- getCPUTime
  args <- getArgs
  let inputFile = parseArgs args
  (lines, chars) <- withFile inputFile ReadMode readdit
  end <- getCPUTime
  let dur = fromIntegral (end - start) / (10 ^ 9) :: Double
  putStrLn $ printf "The input file contains %d lines of text and %d characters. The execution of this script took %.2f ms." lines chars dur
