package mybatis.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mybatis.service.FactoryService;
import mybatis.vo.CartVO;
import mybatis.vo.ProductVO;

public class CartDAO {
 //장바구니  조회
 public static CartVO[] allCart(String us_idx) {
	 SqlSession ss = FactoryService.getFactory().openSession();
	 List<CartVO> list = ss.selectList("cart.all",us_idx);
	 CartVO[] arr = new CartVO[list.size()];
	 for(int i = 0; i<list.size(); i++) {
		 arr[i]=list.get(i);
	 }
	 ss.close();
	 return arr;
 }
 //장바구니 추가
 public static int addCart(Map<String, String> map) {
	 SqlSession ss = FactoryService.getFactory().openSession();
	 int cnt = ss.insert("cart.insert",map);
		if(cnt>0) {
			ss.commit();
		}else{
			ss.rollback();
		}
		ss.close();
		return cnt;
 }
 //장바구니 삭제
 public static int deleteCart(String ca_idx) {
	 SqlSession ss = FactoryService.getFactory().openSession();
	 int cnt = ss.delete("cart.delete",ca_idx);
		if(cnt>0) {
			ss.commit();
		}else{
			ss.rollback();
		}
		ss.close();
		return cnt;
 }
 //장바구니 수량 수정
 public static int updateCart(Map<String, String>map) {
	 SqlSession ss = FactoryService.getFactory().openSession();
	 int cnt = ss.update("cart.update",map);
		if(cnt>0) {
			ss.commit();
		}else{
			ss.rollback();
		}
		ss.close();
		return cnt;
 }
 //장바구니 선택 삭제(장바구니 비우기)
 public static int deleteCarts(Map<String, Object>map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.delete("cart.deleteCarts",map);
		if(cnt>0) {
			ss.commit();
		}else{
			ss.rollback();
		}
		ss.close();
		return cnt;
	}




}
