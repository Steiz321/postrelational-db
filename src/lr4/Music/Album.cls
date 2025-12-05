Class lr4.Music.Album Extends (%Persistent, lr4.Music.MediaContent)
{
    Property CoverArtPath As %String;
    Property ReviewScore As %Integer(MAXVAL = 5, MINVAL = 0);
    Property ArtistRef As lr4.Music.Artist;
    Relationship Tracks As lr4.Music.Track [ Cardinality = children, Inverse = AlbumParent ];
}