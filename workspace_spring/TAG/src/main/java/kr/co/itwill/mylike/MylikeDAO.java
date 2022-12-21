package kr.co.itwill.mylike;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.itwill.QnA.QnADTO;

@Repository
public class MylikeDAO {

	public MylikeDAO() {
		System.out.println("-----MylikeDAO() 객체생성됨");
	}//end
	
	@Autowired
	SqlSession sqlSession;
	
	public List<MylikeDTO> list(String s_m_id){
		return sqlSession.selectList("mylike.list", s_m_id);
	}//list() end
	
	public List<Map<String, String>> like_c(String s_m_id){
		return sqlSession.selectList("mylike.like_c", s_m_id);
	}//like_c() end

	public List<Map<String, String>> like_p(String s_m_id){
		return sqlSession.selectList("mylike.like_p", s_m_id);
	}//like_p() end
	
	public int conCnt(String s_m_id) {
		return sqlSession.selectOne("mylike.conCnt", s_m_id);
	}//conCnt() end
	
	public int proCnt(String s_m_id) {
		return sqlSession.selectOne("mylike.proCnt", s_m_id);
	}//conCnt() end
	
	public List<Map<String, Object>> list_c(String s_m_id, int start, int end){
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_m_id", s_m_id);
		map.put("start", start);
		map.put("end", end);
		
		return sqlSession.selectList("mylike.list_c", map);
	}//list_c() end

	public List<Map<String, Object>> list_p(String s_m_id, int start, int end){
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_m_id", s_m_id);
		map.put("start", start);
		map.put("end", end);
		
		return sqlSession.selectList("mylike.list_p", map);
	}//list_p() end
	
}//class end
