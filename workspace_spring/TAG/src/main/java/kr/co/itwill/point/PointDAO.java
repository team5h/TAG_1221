package kr.co.itwill.point;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PointDAO {

	public PointDAO() {
		System.out.println("-----PointDAO() 객체생성됨");
	}//end
	
	@Autowired
	SqlSession sqlSession;
	
	public int ptCount(String s_m_id) {
		return sqlSession.selectOne("point.ptCount", s_m_id);
	}//tckCount() end
	
	public List<Map<String, Object>> list(String s_m_id, int start, int end){
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_m_id", s_m_id);
		map.put("start", start);
		map.put("end", end);
		
		return sqlSession.selectList("point.list", map);
	}//list() end
	
}//class end
