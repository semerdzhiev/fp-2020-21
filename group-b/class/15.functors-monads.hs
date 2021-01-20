import qualified Data.Map as Map
-- Maybe, List, Tree
-- map
-- context


-- Applicatives
-- Maybe, List



-- Monads

songsMap :: Map.Map Int String
songsMap = Map.fromList [(123, "song-name1"), (345, "song-name2")]

data Song = Song { songId :: Int, duration:: Int } deriving (Show, Eq)

type AlbumName = String
data Album = Album { name :: AlbumName, songs:: [Song] } deriving (Show, Eq)

data Artist = Artist { artistName :: String , albums:: [Album] } deriving (Show, Eq)

longestAlbum :: Artist -> Maybe Album

longestSong :: Album -> Maybe Song

longestTrackOfLongestAlbumName :: Artist -> Maybe String
