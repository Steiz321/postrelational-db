Class lr5.Tests Extends %UnitTest.TestCase
{
/// 1. Test Valid Creation
Method TestValidObject()
{
    Set album = ##class(lr4.Music.Album).%New()
    Set album.Title = "Valid Album"
    Set album.ReviewScore = 5
    
    Set artist = ##class(lr4.Music.Artist).%New()
    Set artist.Name = "Valid Artist"
    Do artist.%Save()
    Set album.ArtistRef = artist
    
    Set sc = album.%Save()
    
    Do $$$AssertStatusOK(sc, "Album should save successfully")
    
    Do ##class(lr4.Music.Album).%DeleteId(album.%Id())
    Do ##class(lr4.Music.Artist).%DeleteId(artist.%Id())
}

/// 2. Test Constraints (ReviewScore Max 5)
Method TestScoreConstraint()
{
    Set album = ##class(lr4.Music.Album).%New()
    Set album.Title = "Bad Score Album"
    // Valid is 0-5. Let's try 10.
    Set album.ReviewScore = 10 
    
    Set sc = album.%Save()
    
    // Assert that the save FAILED
    Do $$$AssertStatusNotOK(sc, "Album with Score 10 should fail to save")
}

/// 3. Test Required Property (Track ISRC)
Method TestRequiredProperty()
{
    Set track = ##class(lr4.Music.Track).%New()
    Set track.Title = "No ISRC Track"
    
    Set sc = track.%Save()
    
    // Assert failure because ISRC is [Required]
    Do $$$AssertStatusNotOK(sc, "Track without ISRC should fail")
}

/// 4. Test Unique Constraint (ISRC)
Method TestUniqueConstraint()
{
    Set t1 = ##class(lr4.Music.Track).%New()
    Set t1.Title = "Original"
    Set t1.ISRC = "TEST-UNIQUE-001"
    Do t1.%Save()
    
    Set t2 = ##class(lr4.Music.Track).%New()
    Set t2.Title = "Copycat"
    Set t2.ISRC = "TEST-UNIQUE-001"
    
    Set sc = t2.%Save()
    
    Do $$$AssertStatusNotOK(sc, "Duplicate ISRC should fail unique check")
    
    Do ##class(lr4.Music.Track).%DeleteId(t1.%Id())
}

/// 5. Test Parent-Child Cascade Delete
Method TestCascadeDelete()
{
    // Create Parent Album
    Set album = ##class(lr4.Music.Album).%New()
    Set album.Title = "To Be Deleted"
    
    // Create Child Track
    Set track = ##class(lr4.Music.Track).%New()
    Set track.Title = "Child Track"
    Set track.ISRC = "DEL-TEST-001"
    Set track.AlbumParent = album
    
    // Save Album (saves track automatically)
    Do album.%Save()
    
    // Remember IDs
    Set albumId = album.%Id()
    Set trackId = track.%Id()
    
    // Verify track exists
    Do $$$AssertTrue(##class(lr4.Music.Track).%ExistsId(trackId), "Track must exist before delete")
    
    // DELETE PARENT
    Do ##class(lr4.Music.Album).%DeleteId(albumId)
    
    // Verify Child is GONE
    Set exists = ##class(lr4.Music.Track).%ExistsId(trackId)
    Do $$$AssertEquals(exists, 0, "Track should be deleted when Album is deleted")
}
}