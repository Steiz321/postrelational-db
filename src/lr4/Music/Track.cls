Class lr4.Music.Track Extends (%Persistent, lr4.Music.MediaContent)
{
    Property ISRC As %String [ Required ];
    Property DurationSeconds As %Integer;
    Property Lyrics As %String(MAXLEN = "");
    Property GenreTags As List Of %String;
    Relationship AlbumParent As lr4.Music.Album [ Cardinality = parent, Inverse = Tracks ];
    Index ISRCIdx On ISRC [ Unique ];

    /// Computed Property
    Property PrintableDuration As %String [ Calculated ];

    /// The Getter Method
    Method PrintableDurationGet() As %String
    {
        If ..DurationSeconds = "" Quit "00:00"
        
        Set min = ..DurationSeconds \ 60
        Set sec = ..DurationSeconds # 60
        
        If $Length(sec) = 1 Set sec = "0"_sec
        If $Length(min) = 1 Set min = "0"_min
        
        Return min_":"_sec
    }
}