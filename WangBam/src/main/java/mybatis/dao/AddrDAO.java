package mybatis.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mybatis.service.FactoryService;
import mybatis.vo.AddressVO;

public class AddrDAO {
    //주소추가
    public int addAddr(Map<String, String> map) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.insert("addr.addAddr", map);
        if(cnt > 0) {
            ss.commit();
        }
        ss.close();
        return cnt;
    }

    //주소가져오기
    public AddressVO[] findAddrList(String us_idx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<AddressVO> list = ss.selectList("addr.findAddrList", us_idx);
        ss.close();
        AddressVO[] arr = new AddressVO[list.size()];
        for(int i = 0; i < list.size(); i++) {
            arr[i] = list.get(i);
        }
        return arr;
    }
    
    //기본 주소 가져오기
    public AddressVO findBasicAddr(String us_idx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        AddressVO result = ss.selectOne("addr.findBasicAddr", us_idx);
        ss.close();
        return result;
    }

    //주소수정
    public int updateAddr(Map<String, String> map) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("addr.updateAddr", map);
        if(cnt > 0) {
            ss.commit();
        }
        ss.close();
        return cnt;
    }
    //기본주소 변경
    public int updateDefaultAddr(Map<String, String> map) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("addr.updateDefaultAddr", map);
        if(cnt > 0) {
            ss.commit();
        }
        ss.close();
        return cnt;
    }

    //주소삭제
    public int deleteAddr(String ad_idx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.delete("addr.deleteAddr", ad_idx);
        if(cnt > 0) {
            ss.commit();
        }
        ss.close();
        return cnt;
    }
}
