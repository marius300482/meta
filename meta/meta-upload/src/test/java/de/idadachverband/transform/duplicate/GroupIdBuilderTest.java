package de.idadachverband.transform.duplicate;

import org.apache.commons.codec.digest.DigestUtils;
import org.testng.annotations.Test;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

public class GroupIdBuilderTest
{
        
    @Test
    public void buildGroupId()
    {
        //String title = "LOGIK - LÜGE - LIBIDO : Christina von Braun und Schmitt, Aïsha zur Vorstellung ihres 2. Buchs \"Nicht ich\"";
        //String author = "Braun, Christina von";
        GroupIdBuilder cut = new GroupIdBuilder(new DuplicateLookupTable());
        
        String actual = cut.buildGroupId("id", "Buch", "author", "title", "2004");
        String expected = /*DigestUtils.md5Hex(*/"Buch|author|title|2004"/*)*/;
        assertThat(actual, equalTo(expected));
    }
    
    @Test
    public void buildGroupIdWithLookup()
    {
        String assignedGroupId = /*DigestUtils.md5Hex(*/"assignedGroupId"/*)*/;
        DuplicateLookupTable lookupTable = new DuplicateLookupTable();
        lookupTable.assign("id", assignedGroupId);
        
        GroupIdBuilder cut = new GroupIdBuilder(lookupTable);
        
        String actual = cut.buildGroupId("id", "Buch", "author", "title", "2004");
        assertThat(actual, equalTo(assignedGroupId));
    }
}
