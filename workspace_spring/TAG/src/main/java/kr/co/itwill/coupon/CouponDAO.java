package kr.co.itwill.coupon;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class CouponDAO {

	public CouponDAO() {
		System.out.println("-----CouponDAO() 객체생성됨");
	}//end
	
	@Autowired
	SqlSession sqlSession;
	
	public List<Map<String, Object>> list(String s_m_id, int start, int end) {
		//System.out.println("-----why!!");
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_m_id", s_m_id);
		map.put("start", start);
		map.put("end", end);
		
		return sqlSession.selectList("coupon.list", map);
	}//list() end
	
	public int cpCount(String s_m_id) {
		return sqlSession.selectOne("coupon.cpCount", s_m_id);
	}//cpCount() end
	
}//class end
