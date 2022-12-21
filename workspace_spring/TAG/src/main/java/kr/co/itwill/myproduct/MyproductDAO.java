package kr.co.itwill.myproduct;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MyproductDAO {

	public MyproductDAO() {
		System.out.println("-----MyproductDAO() 객체생성됨");
	}//end
	
	@Autowired
	SqlSession sqlSession;
	
	public List<Map<String, Object>> list(String s_m_id, int start, int end){
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_m_id", s_m_id);
		map.put("start", start);
		map.put("end", end);
		
		return sqlSession.selectList("myproduct.list", map);
	}//list() end
	
	public int orderCount(String s_m_id) {
		return sqlSession.selectOne("myproduct.orderCount", s_m_id);
	}//orderCount() end
	
	public List<Map<String, Object>> detail(String order_num, int start, int end) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("order_num", order_num);
		map.put("start", start);
		map.put("end", end);

		return sqlSession.selectList("myproduct.detail", map);
	}//detail() end
	
	public int total(String order_num) {
		return sqlSession.selectOne("myproduct.total", order_num);
	}//total() end
	
}//class end
