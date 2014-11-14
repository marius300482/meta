package de.idadachverband.test;

import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.testng.AbstractTestNGSpringContextTests;

/**
 * Subclass for Integration Tests
 * <p/>
 * Created by boehm on 12.11.14.
 */
@ContextConfiguration(locations = {"classpath:spring/ida-beans.xml", "classpath:spring/servlet-context.xml"})
public class AbstractIdaSpringTests extends AbstractTestNGSpringContextTests
{
}
