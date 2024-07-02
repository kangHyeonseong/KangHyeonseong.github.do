package main.java.com.service;

import java.util.List;

import main.java.com.bean.MainVO;

public interface MainService {
	List<MainVO> selectTable() throws Exception;
	List<MainVO> loginCheck(MainVO mainVO) throws Exception;
	void MemberInsert(MainVO mainVO) throws Exception;
	int memberCheck(MainVO mainVO) throws Exception;
	void TableInsert(MainVO mainVO) throws Exception;
}
