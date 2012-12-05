package com.ecko.cms.service;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ecko.cms.Cre;
import com.ecko.cms.dao.CreditDao;
import com.ecko.cms.dao.CreditDetailDao;
import com.ecko.cms.entity.Credit;
import com.ecko.cms.entity.CreditDetail;
import com.ecko.core.entity.Page;
import com.ecko.core.service.DefaultEntityManager;
import com.ecko.core.util.DateManager;
import org.apache.commons.beanutils.BeanUtils;

@Service
@Transactional
public class CreditManager extends DefaultEntityManager<Credit, Long> {

	@Autowired
	private CreditDao creditDao;
	@Autowired
	private CreditDetailDao detailDao;
	
	public Cre find(Long id){
		Cre cre=new Cre();
		Credit c = this.get(id);
		try {
			BeanUtils.copyProperties(cre, c);
		} catch (IllegalAccessException e) {
			 
		} catch (InvocationTargetException e) { 
			 
		}
		Integer clsj=0;
		Date date = c.getCreattime();
		Integer d = DateManager.between(date, new Date());
		Integer y = d / 365;
		clsj=y;
		Float auto = 0f;
		if (y > 3) {
			auto = (y-3) * 0.2f;
			if (auto > 5f)
				auto = 5f;
		}
		cre.setAuto(auto);
		Float credits=0F;
		Date lastDate=c.getCreattime();
		CreditDetail cd=this.detailDao.findLast(c.getId());
		if(cd!=null		){
			lastDate=cd.getOccerdate();
		}
		d=DateManager.between(lastDate, new Date());
		y=d/365;
		credits=y*0.5f;
		if(credits>15f)
			credits=15f;
		cre.setCredits(credits);
		 
		Float add=cre.getAdd()-cre.getReduce()+cre.getAuto()+cre.getCredits();
		if(clsj>=5&&add>30f	){
			cre.setGrade("AAA");
		}else if(clsj>=3&&add>15f	){
			cre.setGrade("AA");
		}else if(add>-5){
			cre.setGrade("A");
		}else if(add<=-5&&add>-30){
			cre.setGrade("B");
		}else if(add<=-30&&add>-50){
			cre.setGrade("C");
		}else{
			cre.setGrade("D");
		}
		
		return cre;
	}

	@SuppressWarnings("unchecked")
	public Page<Credit> list(Page page, Map map) {

		page = this.creditDao.list(page, map);
		List list=new ArrayList();
		List<Credit> ls = page.getResult();
		if (ls != null) {
			for (int i = 0; i < ls.size(); i++) {
				Cre cre=new Cre();
				Credit c = ls.get(i);
				try {
					BeanUtils.copyProperties(cre, c);
				} catch (IllegalAccessException e) {
					 
				} catch (InvocationTargetException e) { 
					 
				}
				Integer clsj=0;
				Date date = c.getCreattime();
				Integer d = DateManager.between(date, new Date());
				Integer y = d / 365;
				clsj=y;
				Float auto = 0f;
				if (y > 3) {
					auto = (y-3) * 0.2f;
					if (auto > 5f)
						auto = 5f;
				}
				cre.setAuto(auto);
				Float credits=0F;
				Date lastDate=c.getCreattime();
				CreditDetail cd=this.detailDao.findLast(c.getId());
				if(cd!=null		){
					lastDate=cd.getOccerdate();
				}
				d=DateManager.between(lastDate, new Date());
				y=d/365;
				credits=y*0.5f;
				if(credits>15f)
					credits=15f;
				cre.setCredits(credits);
				 
				Float add=cre.getAdd()-cre.getReduce();
				if(clsj>=5&&add>30f	){
					cre.setGrade("AAA");
				}else if(clsj>=3&&add>15f	){
					cre.setGrade("AA");
				}else if(add>-5){
					cre.setGrade("A");
				}else if(add<=-5&&add>-30){
					cre.setGrade("B");
				}else if(add<=-30&&add>-50){
					cre.setGrade("C");
				}else{
					cre.setGrade("D");
				}
				list.add(cre);
			}
			page.setResult(list);
		}

		return page;
	}

	public void save(Credit credit) {

		List<CreditDetail> details = credit.getDetails();
		Float add = 0F;
		Float reduce = 0F;
		for (int i = 0; i < details.size(); i++) {
			CreditDetail cd = details.get(i);
			if (cd.getType() == 1) {
				add = add + cd.getScore();

			} else {
				reduce = reduce + cd.getScore();
			}
		}
		credit.setAdd(add);
		credit.setReduce(reduce);
		creditDao.save(credit);
		for (CreditDetail cd : details) {
			cd.setCredit(credit);
			this.detailDao.save(cd);
		}
	}

}
