package com.ecko.cms.service;

import java.util.List;
import java.util.Map;

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
public class ThreadsManager extends DefaultEntityManager<Threads, Long> {

	@Autowired
	private ThreadsDao threadsDao;
	@Autowired
	private PostDao postDao;
	@Autowired
	private BbsForumsDao bbsDao;
	@SuppressWarnings("unchecked")
	public Page<Threads> list(Page<Threads> page, Map map) {
		
		return this.threadsDao.list(page, map);
	}

	public List <Threads>list(Long typeId){
		
		return this.threadsDao.list(typeId);
	}
	 
	
	public void delete(Long [] ids){
		for(Long id:ids){
			Threads t=this.threadsDao.get(id);
			List<Post> posts=t.getPosts();
			for(Post p:posts	){
				this.postDao.delete(p);
			}
			BbsForums bbs=t.getForums();
			bbs.setThreads(bbs.getThreads()-1);
			bbs.setPosts(bbs.getPosts()-t.getReplys());
			bbsDao.save(bbs);
			this.threadsDao.delete(id);
		}
		
	}
}
