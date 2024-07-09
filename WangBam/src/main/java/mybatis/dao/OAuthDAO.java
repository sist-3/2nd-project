package mybatis.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mybatis.service.FactoryService;

public class OAuthDAO {
	static public int add(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.insert("oauth.add", map);
        if(cnt > 0) {
            ss.commit();
        }else{
            ss.rollback();
        }
		ss.close();
		return cnt;
	}
}
