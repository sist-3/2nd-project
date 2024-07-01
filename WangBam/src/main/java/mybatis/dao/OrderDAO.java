package mybatis.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mybatis.service.FactoryService;
import mybatis.vo.OrderVO;

public class OrderDAO {

    public static List<OrderVO> all() {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<OrderVO> list = ss.selectList("order.all");
        ss.close();

        return list;
    }
    
    public static int allCount(Map<String, String> map) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int i = ss.selectOne("order.allCount", map);
        ss.close();

        return i;
    }

    public static List<OrderVO> find(Map<String, String> map) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<OrderVO> list = ss.selectList("order.find", map);
        ss.close();

        return list;
    }

    public static int add(Map<String, String> map) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int result = ss.insert("order.add", map);
        
        if (result > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }

        ss.close();

        return result;
    }

    public static int updateStatusCode(Map<String, String> map) {
        SqlSession ss = FactoryService.getFactory().openSession();
        System.out.println(map);
        int result = ss.update("order.updateStatusCode", map);
        
        if (result > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }

        ss.close();

        return result;
    }
    
    public static OrderVO[] findSalesByMonth(){
    	SqlSession ss = FactoryService.getFactory().openSession();
    	OrderVO[] ar = null;
    	
    	List<OrderVO> list = ss.selectList("order.findSalesByMonth");
    	
    	if(list != null) {
    		ar = new OrderVO[list.size()];
    		list.toArray(ar);
    	}
    	ss.close();
    	
    	return ar;
    }

    public static int findLastIdx() {
        SqlSession ss = FactoryService.getFactory().openSession();
        int idx = ss.selectOne("order.findLastIdx");
        ss.close();

        return idx;
    }
    
    public static OrderVO[] findByUsIdxWithDetail(Map<String, String> map){
        OrderVO[] ar = null;
        SqlSession ss = FactoryService.getFactory().openSession();
        List<OrderVO> list = ss.selectList("order.findByUsIdxWithDetail", map);
        if(list != null){
            ar = new OrderVO[list.size()];
            list.toArray(ar);
        }
        ss.close();

        return ar;
    }


    public static OrderVO findByIdxWithDetail(String or_idx){
        OrderVO ovo = null;
        SqlSession ss = FactoryService.getFactory().openSession();
        ovo = ss.selectOne("order.findByIdxWithDetail", or_idx);
        ss.close();

        return ovo;
    }

    
    public static OrderVO findByOrIdxWithDetail(String or_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        OrderVO vo = ss.selectOne("order.findByOrIdxWithDetail", or_idx);
      
        ss.close();

        return vo;

    }

    public static int countUsIdx(Map<String, String> map){
        SqlSession ss = FactoryService.getFactory().openSession();
        int count = ss.selectOne("order.countUsIdx", map);
        ss.close();

        return count;
    }
}
