package main.java.com.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import main.java.com.bean.MainVO;
import main.java.com.service.MainService;

@Service("mainService")
public class MainServiceImpl implements MainService {

	@Resource(name="mainDAO")
	private MainDAO mainDao;
	
	@Override
	public List<MainVO> selectTable() throws Exception {
		return mainDao.selectTable();
	}
	
	@Override
	public List<MainVO> loginCheck(MainVO mainVO) throws Exception {
		return mainDao.loginCheck(mainVO);
	}
	
	@Override
	public void MemberInsert(MainVO mainVO) throws Exception {
        mainDao.MemberInsert(mainVO);
    }
	
	@Override
	public int memberCheck(MainVO mainVO) throws Exception {
        return mainDao.memberCheck(mainVO);
    }
	
	@Override
	public void TableInsert(MainVO mainVO) throws Exception {
        mainDao.TableInsert(mainVO);
    }
}
