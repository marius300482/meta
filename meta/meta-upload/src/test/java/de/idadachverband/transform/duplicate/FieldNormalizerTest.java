package de.idadachverband.transform.duplicate;

import java.util.Collections;

import org.testng.annotations.Test;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

import de.idadachverband.transform.duplicate.FieldNormalizer.CharacterSet;

public class FieldNormalizerTest {

  @Test
  public void normalizeTitle() 
  {
      FieldNormalizer cut = new FieldNormalizer.Builder()
              .lowercase(true)
              .stripAccents(true)
              .addReplacements(Collections.singletonList("ü"), Collections.singletonList("ue"))
              .tokenizeOn(CharacterSet.LETTERS_AND_DIGITS)
              .build("title");
      
      String title = "LOGIK - LÜGE - LIBIDO : Christina von Braun und Schmitt, Aïsha zur Vorstellung ihres 2. Buchs \"Nicht ich\"";
      String expected = "logik luege libido christina von braun und schmitt aisha zur vorstellung ihres 2 buchs nicht ich";
      String actual = cut.normalize(title);
      assertThat(actual, equalTo(expected));
  }

  @Test
  public void normalizeAuthor() 
  {
      FieldNormalizer cut = new FieldNormalizer.Builder()
      .lowercase(true)
      .addReplacements(Collections.singletonList("[red.]"), Collections.singletonList(""))
      .tokenizeOn(CharacterSet.LETTERS)
      .addStopWords(Collections.singletonList("von"))
      .build("author");
      
      String author = "1: Braun, Christina von [Red.]";
      String expected = "braun christina";
      String actual = cut.normalize(author);
      assertThat(actual, equalTo(expected));
  }
}
