package kr.co.itwill.memberGeneral;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.itwill.coupon.CouponDTO;
import kr.co.itwill.point.PointDTO;

@Repository
public class MemberGeneralDAO {

	public MemberGeneralDAO() {
		System.out.println("------- MemberGeneralDAO() 객체 생성됨 ");
	}//MemberGeneralDAO() end
	
	@Autowired
	SqlSession sqlSession;
	
	
	// 로그인
	public String select(MemberGeneralDTO mem_grade) {
		return sqlSession.selectOne("memberGeneral.select", mem_grade);
	}//memberGeneralInsert() end
	
	
	// 아이디 중복확인
	public int idCheck(String m_id) {
		return sqlSession.selectOne("memberGeneral.idCheck", m_id);
	}//idCheck() end
	
	
	// 이메일 중복확인
	public int emailGcheck(String m_email) {
		return sqlSession.selectOne("memberGeneral.emailGcheck", m_email);
	}//idCheck() end
	
	
	// 회원가입 
	public int joinG(MemberGeneralDTO dto) {
		return sqlSession.insert("memberGeneral.joinG", dto);
	}//joinG end
	
	// 회원가입 포인트 3000점 적립
	public int joinGpoint(PointDTO dto) {
		return sqlSession.insert("memberGeneral.joinGpoint", dto);
	}//joinG end
	
	// 회원가입 배송비 쿠폰 3000점 발급
	public int joinGcoupon(CouponDTO dto) {
		return sqlSession.insert("memberGeneral.joinGcoupon", dto);
	}//joinG end
	
	
	// 회원정보수정
	public MemberGeneralDTO memberupdateG(String m_id){
		//System.out.println(m_id);
		return sqlSession.selectOne("memberGeneral.memberupdateG", m_id);
	}//memberupdateG() end
	
	
	// 회원정보수정 mappers
	public int memberupdateGproc(MemberGeneralDTO dto){
		return sqlSession.update("memberGeneral.memberupdateGproc", dto);
	}//memberupdateGproc() end 
	
}//class end
