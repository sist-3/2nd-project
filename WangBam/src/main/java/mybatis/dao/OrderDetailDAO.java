package mybatis.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mybatis.service.FactoryService;
import mybatis.vo.OrderDetailVO;

public class OrderDetailDAO {

    public static List<OrderDetailVO> all() {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<OrderDetailVO> list = ss.selectList("order_detail.all");
        ss.close();

        return list;
    }

    public static List<OrderDetailVO> find(Map<String, String> map) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<OrderDetailVO> list = ss.selectList("order_detail.find", map);
        ss.close();

        return list;
    }

    public static int add(Map<String, String> map) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int result = ss.insert("order_detail.add", map);
        if (result > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }
        ss.close();

        return result;
    }

    public static List<OrderDetailVO> findByIdxWithProduct(String or_idx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<OrderDetailVO> list = ss.selectList("order_detail.findByIdxWithProduct", or_idx);
        
        return list;
    }
}
