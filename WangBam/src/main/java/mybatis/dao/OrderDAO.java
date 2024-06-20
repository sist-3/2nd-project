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
        int result = ss.update("order.updateStatusCode", map);
        
        if (result > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }

        ss.close();

        return result;
    }
}
