{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_listas_praticas (
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
bindir     = "/workspaces/haskell-ufabc/listas-praticas/.stack-work/install/x86_64-linux/798cb52ffef4821d9351d943e14513db9d4c39d2b9e1cff45d772297bc45a403/9.4.5/bin"
libdir     = "/workspaces/haskell-ufabc/listas-praticas/.stack-work/install/x86_64-linux/798cb52ffef4821d9351d943e14513db9d4c39d2b9e1cff45d772297bc45a403/9.4.5/lib/x86_64-linux-ghc-9.4.5/listas-praticas-0.1.0.0-Gp92TJGc46WKKaLwa0Dpkx-listas-praticas"
dynlibdir  = "/workspaces/haskell-ufabc/listas-praticas/.stack-work/install/x86_64-linux/798cb52ffef4821d9351d943e14513db9d4c39d2b9e1cff45d772297bc45a403/9.4.5/lib/x86_64-linux-ghc-9.4.5"
datadir    = "/workspaces/haskell-ufabc/listas-praticas/.stack-work/install/x86_64-linux/798cb52ffef4821d9351d943e14513db9d4c39d2b9e1cff45d772297bc45a403/9.4.5/share/x86_64-linux-ghc-9.4.5/listas-praticas-0.1.0.0"
libexecdir = "/workspaces/haskell-ufabc/listas-praticas/.stack-work/install/x86_64-linux/798cb52ffef4821d9351d943e14513db9d4c39d2b9e1cff45d772297bc45a403/9.4.5/libexec/x86_64-linux-ghc-9.4.5/listas-praticas-0.1.0.0"
sysconfdir = "/workspaces/haskell-ufabc/listas-praticas/.stack-work/install/x86_64-linux/798cb52ffef4821d9351d943e14513db9d4c39d2b9e1cff45d772297bc45a403/9.4.5/etc"

getBinDir     = catchIO (getEnv "listas_praticas_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "listas_praticas_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "listas_praticas_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "listas_praticas_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "listas_praticas_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "listas_praticas_sysconfdir") (\_ -> return sysconfdir)




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
