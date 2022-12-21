package kr.co.itwill.myticket;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itwill.tickets.TicketDetailDTO;


@Repository
public class MyticketDAO {

	public MyticketDAO() {
		System.out.println("-----MyticketDAO() 객체생성됨");
	}//end
	
	@Autowired
	SqlSession sqlSession;
	
	public List<Map<String, Object>> list(int start, int end, String s_m_id){
		HashMap<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		map.put("m_id", s_m_id);
		
		return sqlSession.selectList("myticket.list", map);
	}//list() end
	
	public int total(){
		return sqlSession.selectOne("myticket.total");
	}//total() end
	

	public Map<String, Object> detail(String tck_num){
		return sqlSession.selectOne("myticket.detail", tck_num);
	}//detail() end
	
	
	public List<TicketDetailDTO> details(String tck_num){
		return sqlSession.selectList("myticket.details", tck_num);
	}//details() end
	
	
	
	//티켓 삭제
	public int deleteDetail(String tck_num){
		return sqlSession.delete("myticket.deleteDetail", tck_num);
	}//deleteDetail() end
	
	public int deleteOrder(String tck_num){
		return sqlSession.delete("myticket.deleteOrder", tck_num);
	}//deleteOrder() end
	

	
}//class end
