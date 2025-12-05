Class lr5.Generator
{

ClassMethod Populate(artistCount As %Integer = 5, albumCount As %Integer = 5) As %Status
{
    Set sc = $$$OK
    Try {
        For i=1:1:artistCount {
            Set artist = ##class(lr4.Music.Artist).%New()
            Set artist.Name = "Artist_"_##class(%PopulateUtils).String(5)
            Set artist.Bio = "Generated Bio "_$Random(100)
            Do artist.%Save()

            // For each artist, generate random albums
            For j=1:1:albumCount {
                Set album = ##class(lr4.Music.Album).%New()
                Set album.Title = "Album "_##class(%PopulateUtils).String(8)
                Set album.ReleaseDate = +$Horolog - $Random(5000)
                Set album.ReviewScore = $Random(6) // 0 to 5
                Set album.ArtistRef = artist
                
                // Add 3 to 6 random tracks per album
                Set trackCount = $Random(4) + 3
                For k=1:1:trackCount {
                    Set track = ##class(lr4.Music.Track).%New()
                    Set track.Title = "Track "_##class(%PopulateUtils).String(5)

                    Set track.ISRC = "GEN-"_$Random(10000)_"-"_i_j_k
                    Set track.DurationSeconds = $Random(300) + 120
                    Set track.AlbumParent = album
                }

                Do album.%Save()
            }
        }
        Write !, "Successfully generated "_artistCount_" Artists and "_(artistCount*albumCount)_" Albums."
    } Catch ex {
        Set sc = ex.AsStatus()
        Write !, "Error: ", $System.Status.GetErrorText(sc)
    }
    Return sc
}

}