Class lr4.Music.Track Extends (%Persistent, lr4.Music.MediaContent)
{
    Property ISRC As %String [ Required ];
    Property DurationSeconds As %Integer;
    Property Lyrics As %String(MAXLEN = "");
    Property GenreTags As List Of %String;
    Relationship AlbumParent As lr4.Music.Album [ Cardinality = parent, Inverse = Tracks ];
    Index ISRCIdx On ISRC [ Unique ];
}