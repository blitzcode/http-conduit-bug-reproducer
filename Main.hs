
import qualified Data.ByteString.Lazy as BL
import Control.Concurrent.Async
import Control.Concurrent
import Control.Monad
import Control.Monad.IO.Class
import Data.Conduit
import Network.HTTP.Conduit
import Control.Applicative
import Text.Printf

main :: IO ()
main = do
    urls <- (cycle . lines) <$> readFile "./urls.txt"
    withManager $ \manager -> liftIO $ do
        as <- forM ([1..5] :: [Int]) $ \i -> async $
            forM_ (drop (i * 50) urls) $ \url ->
                runResourceT $ do
                    req <- parseUrl url
                    res <- httpLbs req manager
                    liftIO $ do BL.writeFile "/dev/null" $ responseBody res
                                tid <- show <$> myThreadId
                                printf "%s: %s\n" tid url 
        forM_ as (wait)

