/*
 *  PhotoReplyBean.java
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
 *  
 */
package com.liusoft.dlog4j.beans;

import com.liusoft.dlog4j.base._ReplyBean;

/**
 * ��Ƭ����
 * 
 * @author Winter Lau
 */
public class PhotoReplyBean extends _ReplyBean {

	protected PhotoOutlineBean photo;

	public PhotoOutlineBean getPhoto() {
		return photo;
	}

	public void setPhoto(PhotoOutlineBean photo) {
		this.photo = photo;
	}

	public int getParentId() {
		return photo.getId();
	}

	/** *** The methods below is for search proxy **** */

	public String name() {
		return "photo_reply";
	}

	public String[] getStoreFields() {
		return new String[] { "site.id", "site.friendlyName", "author",
				"replyTime", "user.id", "user.nickname", "photo.id",
				"photo.name", "photo.previewURL", "content" };
	}

}
