package main.java.com.service.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import main.java.com.bean.MainVO;

@Repository("mainDAO")
public class MainDAO {
    
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
    
    public List<MainVO> selectTable() throws DataAccessException {
        return sqlSessionTemplate.selectList("main.java.com.service.impl.MainDAO.selectTable");
    }

    
    public List<MainVO> loginCheck(MainVO mainVO) throws Exception {
        return sqlSessionTemplate.selectList("main.java.com.service.impl.MainDAO.loginCheck", mainVO);
    }
    
    public void MemberInsert(MainVO mainVO) throws Exception {
        sqlSessionTemplate.insert("main.java.com.service.impl.MainDAO.MemberInsert", mainVO);
    }
    
    public int memberCheck(MainVO mainVO) throws Exception {
    	return sqlSessionTemplate.selectOne("main.java.com.service.impl.MainDAO.memberCheck", mainVO);
    }
    
    public void TableInsert(MainVO mainVO) throws Exception {
        sqlSessionTemplate.insert("main.java.com.service.impl.MainDAO.TableInsert", mainVO);
    }
}
