package mybatis.dao;

import org.apache.ibatis.session.SqlSession;

import mybatis.service.FactoryService;
import mybatis.vo.UserVO;

public class UserDAO {
	public int addUser(UserVO uvo) {
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.insert("user.addUser",uvo);
		if(cnt>0) {
			ss.commit();
		}
		ss.close();
		return cnt;
	}
}
