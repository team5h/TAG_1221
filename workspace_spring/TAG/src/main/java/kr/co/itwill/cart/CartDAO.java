package kr.co.itwill.cart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.itwill.orderDetail.OrderDetailDTO;

@Repository
public class CartDAO {
	
	public CartDAO() {
		System.out.println("------- CartDAO() 객체 생성됨 ");
	}//CartDAO() end
	
	@Autowired
	SqlSession sqlSession;
	

//----------------------------------------------------------- [장바구니 개수]
	public int mycartCnt(String m_id) {
		return sqlSession.selectOne("cart.mycartCnt", m_id);
	}//countUP() end
	
	
	
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
	
//--
	public List<Map<String, Object>> cartorder (CartDTO dto) {
		return sqlSession.selectList("cart.cartorder", dto);
	}
	
	public Map<String, Object> cart_orderPrice (CartDTO dto) {
		return sqlSession.selectOne("cart.cart_orderPrice",dto);
	}
	
	public List<Map<String, Object>> c_nolist (CartDTO dto) {
		return sqlSession.selectList("cart.c_nolist",dto);
	}
	
	public List<Map<String, Object>> mem_cou (CartDTO dto) {
		return sqlSession.selectList("cart.mem_cou" ,dto);
	}
	
	public int mem_couCNT (CartDTO dto) {
		return sqlSession.selectOne("cart.mem_couCNT",dto);
	}
	
	public int cart_orderDtail (List<OrderDetailDTO> list) {
		return sqlSession.insert("cart.cart_orderDtail",list);
	}
}//class end
