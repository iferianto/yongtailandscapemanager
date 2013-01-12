package com.ecko.core.util;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.Assert;

import org.apache.commons.beanutils.PropertyUtils;
public class ReflectionUtils {
	private static Logger logger = LoggerFactory.getLogger(ReflectionUtils.class);

	  public static Object getFieldValue(Object object, String fieldName)
	  {
	    Field field = getDeclaredField(object, fieldName);

	    if (field == null)
	      throw new IllegalArgumentException("Could not find field [" + fieldName + "] on target [" + object + "]");

	    makeAccessible(field);

	    Object result = null;
	    try {
	      result = field.get(object);
	    } catch (IllegalAccessException e) {
	      logger.error("不可能抛出的异常{}", e.getMessage());
	    }
	    return result;
	  }

	  public static void setFieldValue(Object object, String fieldName, Object value)
	  {
	    Field field = getDeclaredField(object, fieldName);

	    if (field == null)
	      throw new IllegalArgumentException("Could not find field [" + fieldName + "] on target [" + object + "]");

	    makeAccessible(field);
	    try
	    {
	      field.set(object, value);
	    } catch (IllegalAccessException e) {
	      logger.error("不可能抛出的异常:{}", e.getMessage());
	    }
	  }

	  protected static Field getDeclaredField(Object object, String fieldName)
	  {
	    Assert.notNull(object);
	    return getDeclaredField(object.getClass(), fieldName);
	  }

	  protected static Field getDeclaredField(Class clazz, String fieldName)
	  {
	    Assert.notNull(clazz);
	    Assert.hasText(fieldName);
	    Class superClass = clazz; if (superClass != Object.class) {
	      try {
	        return superClass.getDeclaredField(fieldName);
	      }
	      catch (NoSuchFieldException e)
	      {
	        superClass = superClass.getSuperclass();
	      }

	    }

	    return null;
	  }

	  protected static void makeAccessible(Field field)
	  {
	    if ((!(Modifier.isPublic(field.getModifiers()))) || (!(Modifier.isPublic(field.getDeclaringClass().getModifiers()))))
	      field.setAccessible(true);
	  }

	  public static Class getSuperClassGenricType(Class clazz)
	  {
	    return getSuperClassGenricType(clazz, 0);
	  }

	  public static Class getSuperClassGenricType(Class clazz, int index)
	  {
	    Type genType = clazz.getGenericSuperclass();

	    if (!(genType instanceof ParameterizedType)) {
	      logger.warn(clazz.getSimpleName() + "'s superclass not ParameterizedType");
	      return Object.class;
	    }

	    Type[] params = ((ParameterizedType)genType).getActualTypeArguments();

	    if ((index >= params.length) || (index < 0)) {
	      logger.warn("Index: " + index + ", Size of " + clazz.getSimpleName() + "'s Parameterized Type: " + params.length);

	      return Object.class;
	    }
	    if (!(params[index] instanceof Class)) {
	      logger.warn(clazz.getSimpleName() + " not set the actual class on superclass generic parameter");
	      return Object.class;
	    }
	    return ((Class)params[index]);
	  }

	  public static List fetchElementPropertyToList(Collection collection, String propertyName)
	    throws Exception
	  {
	    List list = new ArrayList();

	    for (Iterator i$ = collection.iterator(); i$.hasNext(); ) { Object obj = i$.next();
	      list.add(PropertyUtils.getProperty(obj, propertyName));
	    }

	    return list;
	  }

	  public static String fetchElementPropertyToString(Collection collection, String propertyName, String separator)
	    throws Exception
	  {
	    List list = fetchElementPropertyToList(collection, propertyName);
	    return StringUtils.join(list, separator);
	  }
}
