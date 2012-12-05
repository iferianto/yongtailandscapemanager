package com.ecko.core.util;

public class PropertyFilter
{
  private String propertyName;
  private Object value;
  private MatchType matchType = MatchType.EQUAL;

  private Join join=Join.AND;
  public PropertyFilter()
  {
  }
  public PropertyFilter(String propertyName, Object value, MatchType matchType,Join join)
  {
    this.propertyName = propertyName;
    this.value = value;
    this.matchType = matchType;
    this.join=join;
  }
  public PropertyFilter(String propertyName, Object value, MatchType matchType)
  {
    this.propertyName = propertyName;
    this.value = value;
    this.matchType = matchType;
  }

  public Join getJoin() {
	return join;
}
public void setJoin(Join join) {
	this.join = join;
}
public String getPropertyName()
  {
    return this.propertyName;
  }

  public void setPropertyName(String propertyName)
  {
    this.propertyName = propertyName;
  }

  public Object getValue() {
    return this.value;
  }

  public void setValue(Object value) {
    this.value = value;
  }

  public MatchType getMatchType() {
    return this.matchType;
  }

  public void setMatchType(MatchType matchType) {
    this.matchType = matchType;
  }

  public static enum MatchType
  {
    EQUAL, LIKE,GE,GT,LE,LT,IN,NE;
  }
  
  public static enum Join{
	  OR,AND,NOT
  }
}