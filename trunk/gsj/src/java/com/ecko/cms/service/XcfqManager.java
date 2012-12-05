package com.ecko.cms.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ecko.cms.dao.XcfqDao;
import com.ecko.cms.dao.XcfqDetailDao;
import com.ecko.cms.entity.Xcfq;
import com.ecko.cms.entity.XcfqDetail;
import com.ecko.core.entity.Page;
import com.ecko.core.service.DefaultEntityManager;

@Service
@Transactional
public class XcfqManager extends DefaultEntityManager<Xcfq, Long> {

	@Autowired
	private XcfqDao xcfqDao;
	
	@Autowired
	private XcfqDetailDao detailDao;

	@SuppressWarnings("unchecked")
	public Page list(Page page, Map map) {
		return this.xcfqDao.list(page, map);
	}
	
	public List<XcfqDetail> findDetails(Long id){
		
		return this.detailDao.findDetails(id);
	}
	
	public void save(Xcfq xcfg ,List<XcfqDetail> details){
		this.xcfqDao.save(xcfg);
		for(XcfqDetail detail:details){
			detail.setXcfq(xcfg);
			this.detailDao.save(detail);
		}
	}
	
//	public void delete(Long[] ids){
//		for(Long id:ids){
//			Xcfq x=this.get(id);
////			List ls=x.get
//		}
//		
//	}
}
