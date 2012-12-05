package com.ecko.core.entity;



import java.util.Collections;
import java.util.List;
import org.apache.commons.lang.StringUtils;

public class Page<T>
{
  public static final String ASC = "asc";
  public static final String DESC = "desc";
  public static final int MIN_PAGESIZE = 5;
  public static final int MAX_PAGESIZE = 200;
  protected int pageNo = 1;
  protected int pageSize = 15;
  protected String orderBy = null;
  protected String order = "asc";
  protected boolean autoCount = true;
  protected List<T> result = null;
  protected long totalCount = -1;

  public Page()
  {
  }

  public Page(int pageSize)
  {
    setPageSize(pageSize);
  }

  public Page(int pageSize, boolean autoCount) {
    setPageSize(pageSize);
    this.autoCount = autoCount;
  }

  public int getPageNo()
  {
    return this.pageNo;
  }

  public void setPageNo(int pageNo)
  {
    this.pageNo = pageNo;

    if (pageNo < 1)
      this.pageNo = 1;
  }

  public int getPageSize()
  {
    return this.pageSize;
  }

  public void setPageSize(int pageSize)
  {
    this.pageSize = pageSize;

    if (pageSize < 5)
      this.pageSize = 5;

    if (pageSize > 200)
      this.pageSize = 200;
  }

  public int getFirst()
  {
    return ((this.pageNo - 1) * this.pageSize);
  }

  public String getOrderBy()
  {
    return this.orderBy;
  }

  public void setOrderBy(String orderBy)
  {
    this.orderBy = orderBy;
  }

  public boolean isOrderBySetted()
  {
    return StringUtils.isNotBlank(this.orderBy);
  }

  public String getOrder()
  {
    return this.order;
  }

  public void setOrder(String order)
  {
    String[] orders = StringUtils.split(order, ',');
    String[] arr$ = orders; int len$ = arr$.length; for (int i$ = 0; i$ < len$; ++i$) { String orderStr = arr$[i$];
      if ((!(StringUtils.equalsIgnoreCase("desc", orderStr))) && (!(StringUtils.equalsIgnoreCase("asc", orderStr))))
        throw new IllegalArgumentException("排序方向" + orderStr + "不是合法值");
    }

    this.order = order.toLowerCase();
  }

  public String getPageRequest()
  {
    return getPageNo() + "|" + StringUtils.defaultString(getOrderBy()) + "|" + getOrder();
  }

  public void setPageRequest(String pageRequest)
  {
    if (StringUtils.isBlank(pageRequest))
      return;

    String[] params = StringUtils.splitPreserveAllTokens(pageRequest, '|');

    if (StringUtils.isNumeric(params[0])) {
      setPageNo(Integer.valueOf(params[0]).intValue());
    }

    if (StringUtils.isNotBlank(params[1])) {
      setOrderBy(params[1]);
    }

    if (StringUtils.isNotBlank(params[2]))
      setOrder(params[2]);
  }

  public boolean isAutoCount()
  {
    return this.autoCount;
  }

  public void setAutoCount(boolean autoCount)
  {
    this.autoCount = autoCount;
  }

  public List<T> getResult()
  {
    if (this.result == null)
      return Collections.emptyList();
    return this.result;
  }

  public void setResult(List<T> result) {
    this.result = result;
  }

  public long getTotalCount()
  {
    return this.totalCount;
  }

  public void setTotalCount(long totalCount) {
    this.totalCount = totalCount;
  }

  public long getTotalPages()
  {
    if (this.totalCount < 0)
      return -1;

    long count = this.totalCount / this.pageSize;
    if (this.totalCount % this.pageSize > 0)
      ++count;

    return count;
  }

  public boolean isHasNext()
  {
    return (this.pageNo + 1 <= getTotalPages());
  }

  public int getNextPage()
  {
    if (isHasNext())
      return (this.pageNo + 1);

    return this.pageNo;
  }

  public boolean isHasPre()
  {
    return (this.pageNo - 1 >= 1);
  }

  public int getPrePage()
  {
    if (isHasPre())
      return (this.pageNo - 1);

    return this.pageNo;
  }

  public String getInverseOrder()
  {
    String[] orders = StringUtils.split(this.order, ',');

    for (int i = 0; i < orders.length; ++i)
      if ("desc".equals(orders[i]))
        orders[i] = "asc";
      else
        orders[i] = "desc";


    return StringUtils.join(orders);
  }
}