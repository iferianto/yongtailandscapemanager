/*
 *  BookmarkForm.java
 *  
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Library General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *  
 *  Author: Winter Lau (javayou@gmail.com)
 *  http://dlog4j.sourceforge.net
 */
package com.liusoft.dlog4j.formbean;

/**
 * ��ǩ����
 * @author Winter Lau
 */
public class BookmarkForm extends FormBean {

	protected String title;
	protected int parentId;
	protected int parentType;
	
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}
	public int getParentType() {
		return parentType;
	}
	public void setParentType(int parentType) {
		this.parentType = parentType;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
}
