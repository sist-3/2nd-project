package mybatis.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mybatis.service.FactoryService;
import mybatis.vo.UserVO;

public class UserDAO {
	// 유저 추가
	public int addUser(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.insert("user.addUser",map);
		if(cnt>0) {
			ss.commit();
		}
		ss.close();
		return cnt; 
	}
	
	// 로그인
	public UserVO login(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		UserVO result = ss.selectOne("user.login",map);
		ss.close();
		return result;
	}

	//아이디 찾기
	public String findId(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		String result = ss.selectOne("user.findId",map);
		ss.close();
		return result;
	}

	// 비밀번호 찾기 
	public String findPw(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		String result = ss.selectOne("user.findPw",map);
		ss.close();
		return result;
	}

	// 유저 삭제
	public int deleteUser(String us_idx) {
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.delete("user.deleteUser",us_idx);
		if(cnt>0) {
			ss.commit();
		}
		ss.close();
		return cnt;
	}

	// 유저 수정
	public int updateUser(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.update("user.updateUser",map);
		if(cnt>0) {
			ss.commit();
		}
		ss.close();
		return cnt;
	}

	//모든유저
	public UserVO[] AllUser() {
		SqlSession ss = FactoryService.getFactory().openSession();
		List<UserVO> list = ss.selectList("user.AllUser");
		UserVO[] arr = new UserVO[list.size()];
		arr = list.toArray(arr);
		ss.close();
		return arr;
	}	
	//특정 유저 검색
	public UserVO[] findUser(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		List<UserVO> list = ss.selectList("user.findUser",map);
		UserVO[] arr = new UserVO[list.size()];
		if(list.size()>0&&list!=null) {
			arr = list.toArray(arr);
			ss.close();
			return arr;
		}
		ss.close();
		ss.close();
		return arr;
	}

	//유저 한명 검색
	public UserVO findUserInfo(String us_idx) {
		SqlSession ss = FactoryService.getFactory().openSession();
		UserVO result = ss.selectOne("user.findUserInfo",us_idx);
		ss.close();
		return result;
	}
}
