package kr.co.itwill.cart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CartDAO {
	
	public CartDAO() {
		System.out.println("------- CartDAO() 객체 생성됨 ");
	}//CartDAO() end
	
	@Autowired
	SqlSession sqlSession;
	

//----------------------------------------------------------- [장바구니 리스트]
	public List<Map<String, String>> mycartList(String m_id){
		
		HashMap<String, String> map  = new HashMap<>();
		map.put("m_id", m_id);
		
		return sqlSession.selectList("cart.mycartList", map);
	}//mycartList() end
	
	
//----------------------------------------------------------- [장바구니 배송비 - 테스트용 . 로직짜야함]
	public List<Map<String, String>> sameCompany(String m_id){		
		HashMap<String, String> map  = new HashMap<>();
		map.put("m_id", m_id);
		
		return sqlSession.selectList("cart.sameCompany", m_id);
	}//mycartList() end


//----------------------------------------------------------- [장바구니 수량 증가]
	public int countUp(CartDTO cart_no) {
		return sqlSession.update("cart.countUp", cart_no);
	}//countUP() end
	
	
//----------------------------------------------------------- [장바구니 수량 감소]
	public int countDown(CartDTO cart_no) {
		return sqlSession.update("cart.countDown", cart_no);
	}//countUP() end

	
//----------------------------------------------------------- [장바구니 삭제]	
	public int deleteMycart(CartDTO cart_no) {
		return sqlSession.delete("cart.deleteMycart", cart_no);
	}//deleteMycart() end
	
	
//----------------------------------------------------------- [장바구니 선택 삭제]	
	public int selectDelete(CartDTO cart_no) {
		return sqlSession.delete("cart.selectDelete", cart_no);
	}//deleteMycart() end	
	
	
}//class end
