package kr.co.itwill.notice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO {

	public NoticeDAO() {
		System.out.println("-----NoticeDAO() 객체생성됨");
	}//end
	
	@Autowired
	SqlSession sqlSession;
	
	
	public void insert(NoticeDTO notice) {
		sqlSession.insert("notice.insert", notice);
	}//insert() end
	
	public List<NoticeDTO> list(int start, int end) {
		HashMap<String, Integer> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		
		return sqlSession.selectList("notice.list", map);
	}//list() end
	
	public int total() {
		return sqlSession.selectOne("notice.total");
	}//total() end

	public NoticeDTO detail(int n_no) {		
		return sqlSession.selectOne("notice.detail", n_no);
	}//detail() end
	
	public void update(NoticeDTO dto) {
		try {			
			sqlSession.update("notice.update", dto);

		}catch (Exception e){
			e.printStackTrace();
		}
	}//update() end
	
	public void delete(int n_no) {
		sqlSession.delete("notice.delete", n_no);
	}//delete() end
	
	
	
	
}//class end
