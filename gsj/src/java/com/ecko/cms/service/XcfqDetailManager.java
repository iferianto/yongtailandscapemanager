package com.ecko.cms.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ecko.cms.entity.XcfqDetail;
import com.ecko.core.service.DefaultEntityManager;
@Service
@Transactional
public class XcfqDetailManager extends DefaultEntityManager<XcfqDetail, Long> {

}
