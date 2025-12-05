Class lr4.Music.Printer
{

ClassMethod PrintReport()
{
    Write !, "========================================="
    Write !, "       MUSIC LIBRARY REPORT"
    Write !, "=========================================",!

    Set sql = "SELECT ID FROM lr4_Music.Album"
    Set rs = ##class(%SQL.Statement).%ExecDirect(,sql)

    While rs.%Next() {
        Set albumId = rs.%Get("ID")
        Set album = ##class(lr4.Music.Album).%OpenId(albumId)

        Write !, "ALBUM: ", album.Title

        Write !, " > Artist: ", album.ArtistRef.Name
        Write !, " > Score:  ", album.ReviewScore, "/5"
        
        Write !, " > Tracklist:"
        
        Set key = ""
        Do {
            Set track = album.Tracks.GetNext(.key)
            If (track '= "") {
                Write !, "    - [", track.ISRC, "] ", track.Title, " (", track.DurationSeconds, "s)"
                
                Write " Tags: "
                For i=1:1:track.GenreTags.Count() {
                    Write track.GenreTags.GetAt(i)
                    If i < track.GenreTags.Count() Write ", "
                }
            }
        } While (key '= "")
        Write !, "-----------------------------------------"
    }

    Write !!, "========================================="
    Write !, "       USER SETTINGS REPORT"
    Write !, "=========================================",!

    Set sql = "SELECT ID FROM lr4_Music.Listener"
    Set rs = ##class(%SQL.Statement).%ExecDirect(,sql)

    While rs.%Next() {
        Set lId = rs.%Get("ID")
        Set listener = ##class(lr4.Music.Listener).%OpenId(lId)

        Write !, "USER:    ", listener.Nickname
        
        Write !, "ADDRESS: ", listener.BillingAddress.Street, ", ", listener.BillingAddress.City

        Write !, "SETTINGS:"

        Set setKey = ""
        Do {
            Set val = listener.Settings.GetNext(.setKey)
            If (setKey '= "") {
                Write !, "   * ", setKey, " = ", val
            }
        } While (setKey '= "")
        Write !, "-----------------------------------------"
    }
}

}