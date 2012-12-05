package com.ecko.cms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ecko.cms.dao.BbsForumsDao;
import com.ecko.cms.dao.PostDao;
import com.ecko.cms.dao.ThreadsDao;
import com.ecko.cms.entity.BbsForums;
import com.ecko.cms.entity.Post;
import com.ecko.cms.entity.Threads;
import com.ecko.core.entity.Page;
import com.ecko.core.service.DefaultEntityManager;
@Service
@Transactional
public class PostManager extends DefaultEntityManager<Post, Long> {

	@Autowired
	private PostDao postDao;
	@Autowired
	private ThreadsDao threadsDao;
	@Autowired
	private BbsForumsDao bbsDao;
	
	@SuppressWarnings("unchecked")
	public Page<Post>list(Long threadId,Page page){
		
		return this.postDao.list(threadId, page);
	}
	
	public void delete(Long id){
		Post post=this.postDao.get(id);
		Threads ts=post.getThread();
		ts.setReplys(ts.getReplys()-1);
		threadsDao.save(ts);
		BbsForums bbs=post.getBbsForums();
		bbs.setPosts(bbs.getPosts()-1);
		bbsDao.save(bbs);
		postDao.delete(post);
	}
}
