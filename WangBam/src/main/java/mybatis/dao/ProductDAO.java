package mybatis.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mybatis.service.FactoryService;
import mybatis.vo.AddressVO;
import mybatis.vo.ProductVO;

public class ProductDAO {

	//상품상세페이지 조회
	public static ProductVO findByid(String pd_idx) {
		SqlSession ss = FactoryService.getFactory().openSession();
		ProductVO vo = ss.selectOne("product.findByid",pd_idx);
		return vo;
		
	}

	//상품 리스트 조회
	public static ProductVO[] allProduct() {
		SqlSession ss = FactoryService.getFactory().openSession();
		List<ProductVO> list = ss.selectList("product.all");
		ss.close();
		ProductVO[] arr = new ProductVO[list.size()];
        if(list.size()>0&&list!=null) {
            arr = list.toArray(arr);
        }
        return arr;
		
	}
	//상품 등록
	public static int addProduct(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.insert("product.add",map);
		ss.close();
		if(cnt>0) {
			ss.commit();
		}else{
			ss.rollback();
		}
		return cnt;
	}

	//상품 수정
	public static int updateProduct(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.update("product.update",map);
		ss.close();
		if(cnt>0) {
			ss.commit();
		}else{
			ss.rollback();
		}
		return cnt;
	}

	//상품 삭제
	public static int deleteProduct(String pd_idx) {
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.delete("product.delete",pd_idx);
		ss.close();
		if(cnt>0) {
			ss.commit();
		}else{
			ss.rollback();
		}
		return cnt;
	}

	// 모든 상품 리스트 조회해서 페이지네이션 하기
	public static ProductVO[] allProduct(String start,String end) {
		
		SqlSession ss = FactoryService.getFactory().openSession();
		HashMap<String, String> map = new HashMap<>();
		map.put("start", String.valueOf(start));
		map.put("end", String.valueOf(end));
		List<ProductVO> list = ss.selectList("product.page", map);
		ss.close();
		return list.toArray(new ProductVO[0]);
	}

	//상품 이름(pd_name)으로 검색하는 기능
	public static ProductVO[] findProduct(String pd_name) {
		SqlSession ss = FactoryService.getFactory().openSession();
		List<ProductVO> list = ss.selectList("product.find_pd", pd_name);
		ss.close();
		return list.toArray(new ProductVO[0]);
	}
}
