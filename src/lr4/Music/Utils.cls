Class lr4.Music.Utils
{

ClassMethod SeedData()
{
    Write "Creating Artists...",!
    
    Set a1 = ##class(lr4.Music.Artist).%New()
    Set a1.Name = "Pink Floyd"
    Set a1.Bio = "English rock band formed in London."
    Do a1.%Save()

    Set a2 = ##class(lr4.Music.Artist).%New()
    Set a2.Name = "Daft Punk"
    Set a2.Bio = "French electronic music duo."
    Do a2.%Save()

    Write "Creating Albums...",!
    
    Set album1 = ##class(lr4.Music.Album).%New()
    Set album1.Title = "The Dark Side of the Moon"
    Set album1.ReleaseDate = $ZDateH("1973-03-01", 3)
    Set album1.ReviewScore = 5
    Set album1.ArtistRef = a1

    Set album2 = ##class(lr4.Music.Album).%New()
    Set album2.Title = "Discovery"
    Set album2.ReleaseDate = $ZDateH("2001-03-12", 3)
    Set album2.ReviewScore = 4
    Set album2.ArtistRef = a2

    Write "Adding Tracks...",!

    Set t1 = ##class(lr4.Music.Track).%New()
    Set t1.Title = "Money"
    Set t1.ISRC = "GB-001-73-00001"
    Set t1.DurationSeconds = 382
    Set t1.Lyrics = "Money, get away..."
    Do t1.GenreTags.Insert("Prog Rock")
    Do t1.GenreTags.Insert("Classic")
    Set t1.AlbumParent = album1

    Set t2 = ##class(lr4.Music.Track).%New()
    Set t2.Title = "Time"
    Set t2.ISRC = "GB-001-73-00002"
    Set t2.DurationSeconds = 421
    Set t2.Lyrics = "Ticking away the moments..."
    Do t2.GenreTags.Insert("Rock")
    Set t2.AlbumParent = album1

    Set t3 = ##class(lr4.Music.Track).%New()
    Set t3.Title = "One More Time"
    Set t3.ISRC = "FR-001-01-00001"
    Set t3.DurationSeconds = 320
    Set t3.Lyrics = "One more time, we're gonna celebrate..."
    Do t3.GenreTags.Insert("House")
    Do t3.GenreTags.Insert("Electronic")
    Set t3.AlbumParent = album2

    Do album1.%Save()
    Do album2.%Save()

    Write "Creating Listeners...",!

    Set l1 = ##class(lr4.Music.Listener).%New()
    Set l1.Nickname = "AudioPhile_99"

    Do l1.Settings.SetAt("Dark", "Theme")
    Do l1.Settings.SetAt("100", "Volume")

    Set l1.BillingAddress.City = "New York"
    Set l1.BillingAddress.Street = "5th Avenue"
    Do l1.%Save()

    Set l2 = ##class(lr4.Music.Listener).%New()
    Set l2.Nickname = "CasualUser"
    Do l2.Settings.SetAt("Light", "Theme")
    Set l2.BillingAddress.City = "London"
    Set l2.BillingAddress.Street = "Baker St"
    Do l2.%Save()

    Write "Success! All objects saved.",!
}

}