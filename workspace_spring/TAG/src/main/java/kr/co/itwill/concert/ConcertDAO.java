package kr.co.itwill.concert;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.itwill.mylike.MylikeDTO;
import kr.co.itwill.product.ProductDTO;

@Repository
public class ConcertDAO {

	public ConcertDAO() {
		System.out.println("------- ConcertDAO() 객체 생성됨 ");
	}//ConcertDAO() end
	
	@Autowired
	SqlSession sqlSession;
	
//  ---------------------------------------------------- [콘서트 목록 최신순 - 개수]
	public int concertTotal() {
		return sqlSession.selectOne("concert.concertTotal");
	}//concertTotal() end
	
	
//  ---------------------------------------------------- [콘서트 목록 최신순 - 전체]
	public List<ConcertDTO> concertListLatest(int start, int end){
		HashMap<String, Integer> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		
		return sqlSession.selectList("concert.concertListLatest", map);
	}//concertListLatest() end
	
//  ---------------------------------------------------- [콘서트 목록 최신순 - 전체]
	public List<ConcertDTO> popularAll(int start, int end){
		HashMap<String, Integer> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		
		return sqlSession.selectList("concert.popularAll", map);
	}//concertListLatest() end
	
//  ---------------------------------------------------- [콘서트 목록 최신순 - 전체]
	public List<ConcertDTO> likeAll(int start, int end){
		HashMap<String, Integer> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		
		return sqlSession.selectList("concert.likeAll", map);
	}//concertListLatest() end
	
	
	
//  ---------------------------------------------------- [종료된 콘서트 목록 - 개수]
	public int pastConcertTotal() {
		return sqlSession.selectOne("concert.pastConcertTotal");
	}//concertTotal() end
	
//  ---------------------------------------------------- [종료된 콘서트 목록 - 전체]	
	public List<ConcertDTO> pastConcertList(int start, int end) {
		HashMap<String, Integer> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		
		return sqlSession.selectList("concert.pastConcertList", map);
	}//pastConcertList end
	

	
	
//  ---------------------------------------------------- [예정된 콘서트 목록 - 전체]	
	public List<ConcertDTO> yejungConcertList(int start, int end) {
		HashMap<String, Integer> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		
		return sqlSession.selectList("concert.yejungConcertList", map);
	}//pastConcertList end
	
	
//  ---------------------------------------------------- [예정된 콘서트 목록 - 개수]
	public int yejungConcertTotal() {
		return sqlSession.selectOne("concert.yejungConcertTotal");
	}//concertTotal() end
	
//  ---------------------------------------------------- [콘서트검색 - 개수]	
	public int searchConcertCnt(String title) {
		return sqlSession.selectOne("concert.searchConcertCnt", "%" + title.toUpperCase() + "%");
	}// searchConcertCnt() end	
	
//  ---------------------------------------------------- [콘서트검색]	
	public List<Map<String, Object>> searchConcert(String title) {
		return sqlSession.selectList("concert.searchConcert", "%" + title.toUpperCase() + "%");
	}//search() end
	

//  ---------------------------------------------------- [콘서트상세]	
	public Map<String, Object> detailConcert(String c_no){
		return sqlSession.selectOne("concert.detailConcert", c_no);
	}//detail() end
	

// ---------------------------------------------------- [오늘이 선결제 예매일인지 ?]	
	public int earlybirdCheck(String c_no) {
		//System.out.println("22222222");
		return sqlSession.selectOne("concert.earlybirdCheck", c_no);
	}//earlybirdCheck() end
	
	

// ---------------------------------------------------- [flagNum 가져오기 -다슬-]	
	public List<Map<String, Object>> getFlagnum(String c_no) {
		return sqlSession.selectList("concert.getFlagnum", c_no);
	}//getFlagnum() end



// ---------------------------------------------------- [공연상세 좋아요 개수 증가]	
	public int likecntInc(ConcertDTO c_no) {
		//System.out.println("DAO 잘 들어옴.");
		return sqlSession.update("concert.likecntInc", c_no);
	}//likecntUpdate() end
	

// ---------------------------------------------------- [공연상세 나의 좋아요 개수 증가]	
	public int likechk (String m_id, String c_no) {
	      Map<String, Object> map = new HashMap<>();
	      
	      map.put("c_no", c_no);
	      map.put("m_id", m_id);
	      
	      return sqlSession.selectOne("concert.likechk", map); 
	   }// end

	
	
// ---------------------------------------------------- [나의 상품(마이페이지에) 좋아요 insert]		
	public int myLikeInsert(Map<String, String> map){
		//System.out.println("도착완?");
		return sqlSession.insert("concert.myLikeInsert", map);
	}//myLikeInsert() end
	
	
// ---------------------------------------------------- [공연상세 좋아요 개수 감소]	
	public int likecntDec(ConcertDTO c_no) {
		//System.out.println("DAO 잘 들어옴.");
		return sqlSession.update("concert.likecntDec", c_no);
	}//likecntUpdate() end
	
	
// ---------------------------------------------------- [나의 상품(마이페이지에) 좋아요 삭제]		
	public int myLikeDelete(Map<String, String> map) {
		return sqlSession.delete("concert.myLikeDelete", map);
	}//myLikeDelete() end
	
	

}//class end
