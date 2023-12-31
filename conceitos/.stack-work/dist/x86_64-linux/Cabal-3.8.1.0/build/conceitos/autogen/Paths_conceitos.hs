{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_conceitos (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/workspaces/haskell-ufabc/conceitos/.stack-work/install/x86_64-linux/2b6d456cf7e235527d0572deca331fa2c97826a64726bab26531edb575c61d9e/9.4.5/bin"
libdir     = "/workspaces/haskell-ufabc/conceitos/.stack-work/install/x86_64-linux/2b6d456cf7e235527d0572deca331fa2c97826a64726bab26531edb575c61d9e/9.4.5/lib/x86_64-linux-ghc-9.4.5/conceitos-0.1.0.0-GG8z6K0XjW2A07fz1m6CuE-conceitos"
dynlibdir  = "/workspaces/haskell-ufabc/conceitos/.stack-work/install/x86_64-linux/2b6d456cf7e235527d0572deca331fa2c97826a64726bab26531edb575c61d9e/9.4.5/lib/x86_64-linux-ghc-9.4.5"
datadir    = "/workspaces/haskell-ufabc/conceitos/.stack-work/install/x86_64-linux/2b6d456cf7e235527d0572deca331fa2c97826a64726bab26531edb575c61d9e/9.4.5/share/x86_64-linux-ghc-9.4.5/conceitos-0.1.0.0"
libexecdir = "/workspaces/haskell-ufabc/conceitos/.stack-work/install/x86_64-linux/2b6d456cf7e235527d0572deca331fa2c97826a64726bab26531edb575c61d9e/9.4.5/libexec/x86_64-linux-ghc-9.4.5/conceitos-0.1.0.0"
sysconfdir = "/workspaces/haskell-ufabc/conceitos/.stack-work/install/x86_64-linux/2b6d456cf7e235527d0572deca331fa2c97826a64726bab26531edb575c61d9e/9.4.5/etc"

getBinDir     = catchIO (getEnv "conceitos_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "conceitos_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "conceitos_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "conceitos_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "conceitos_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "conceitos_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
