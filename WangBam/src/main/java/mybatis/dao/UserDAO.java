package mybatis.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mybatis.service.FactoryService;
import mybatis.vo.OrderVO;
import mybatis.vo.UserVO;

public class UserDAO {
	// 유저 추가
	static public int add(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.insert("user.add",map);
		if(cnt>0) {
			ss.commit();
		}else{
			ss.rollback();
		}
		
		int c = ss.insert("addr.add",map);
		if(c>0) {
			ss.commit();
		}else{
			ss.rollback();
		}
		ss.close();
		return cnt; 
	}
	
	// 로그인
	static public UserVO login(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		UserVO result = ss.selectOne("user.login",map);
		ss.close();
		return result;
	}

	//아이디 찾기
	static public String findId(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		String result = ss.selectOne("user.findUserEmail",map);
		ss.close();
		return result;
	}

	// 비밀번호 찾기 
	static public String findPw(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		String result = ss.selectOne("user.findPw",map);
		ss.close();
		return result;
	}

	// 유저 삭제
	static public int delete(String us_idx) {
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.delete("user.delete",us_idx);
		if(cnt>0) {
			ss.commit();
		}
		ss.close();
		return cnt;
	}

	// 유저 수정
	static public int update(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.update("user.update",map);
		if(cnt>0) {
			ss.commit();
		}
		ss.close();
		return cnt;
	}

	//모든유저
	static public UserVO[] all() {
		SqlSession ss = FactoryService.getFactory().openSession();
		List<UserVO> list = ss.selectList("user.all");
		UserVO[] arr = new UserVO[list.size()];
		if(list.size()>0&&list!=null) {
			arr = list.toArray(arr);
		}
		ss.close();
		return arr;
	}	
	//특정 유저 검색
	static public UserVO[] search(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		List<UserVO> list = ss.selectList("user.searchUserList",map);
		UserVO[] arr = new UserVO[list.size()];
		if(list.size()>0&&list!=null) {
			arr = list.toArray(arr);
		}
		ss.close();
		return arr;
	}
	//페이징용
	static public int count(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.selectOne("user.count", map);
		ss.close();
		return cnt;
	}
	
	//유저 한명 검색
	static public UserVO findByidx(String us_idx) {
		SqlSession ss = FactoryService.getFactory().openSession();
		UserVO result = ss.selectOne("user.findByidx",us_idx);
		ss.close();
		return result;
	}

	static public UserVO findByEmail(String us_email) {
		SqlSession ss = FactoryService.getFactory().openSession();
		UserVO result = ss.selectOne("user.findByEmail",us_email);
		ss.close();
		return result;
	}
	static public UserVO findByNickname(String us_nickname) {
		SqlSession ss = FactoryService.getFactory().openSession();
		UserVO result = ss.selectOne("user.findByNickname",us_nickname);
		ss.close();
		return result;
	}
	
    // VIP
    public static UserVO[] findByVIP() {
    	SqlSession ss = FactoryService.getFactory().openSession();
    	UserVO[] ar = null;
    	
    	List<OrderVO> list = ss.selectList("user.findByVIP");
    	
    	if(list != null) {
    		ar = new UserVO[list.size()];
    		list.toArray(ar);
    	}
    	ss.close();
    	
    	return ar;
    }

	public static UserVO[] findByNameAndTel(Map<String, Object> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		UserVO[] ar = null;
		List<UserVO> list = ss.selectList("user.findByNameAndTel", map);
		if(list != null) {
			ar = new UserVO[list.size()];
			list.toArray(ar);
		}
		ss.close();
		return ar;
	}
}
