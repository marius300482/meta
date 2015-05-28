package de.idadachverband.utils;

import java.util.Comparator;

public class ToStringIgnoringCaseComparator implements Comparator<Object>
{
    public static ToStringIgnoringCaseComparator INSTANCE = new ToStringIgnoringCaseComparator();
    
    @Override
    public int compare(Object o1, Object o2)
    {
        return o1.toString().compareToIgnoreCase(o2.toString());
    }
}
