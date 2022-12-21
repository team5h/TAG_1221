package kr.co.itwill.cart;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.itwill.memberSeller.SellerProductDTO;

@Controller
public class CartCont {
	
	public CartCont() {
		System.out.println("------- CartCont() 객체 생성됨 ");
	}// CartCont()

	
	@Autowired
	CartDAO cartDao;
	
	

//----------------------------------------------------------- [장바구니 리스트]
	@RequestMapping("/cart")
	public ModelAndView cart(HttpServletRequest req, HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		String m_id = (String) session.getAttribute("s_m_id");
		
		//System.out.println(cartDao.deliveryFee(m_id));
		
        mav.setViewName("/cart/cartList");
		
        //System.out.println(cartDao.mycartList(m_id));
        //cartDao.mycartList(m_id);
        mav.addObject("mycart", cartDao.mycartList(m_id));
        mav.addObject("total", cartDao.sameCompany(m_id));
        return mav;
	}// concertList() end
	

//----------------------------------------------------------- [장바구니 수량 증가]	
	@RequestMapping("/cart/countUp")
	@ResponseBody
	private int countUp(@RequestParam int cart_no) throws Exception {
		
		CartDTO cart = new CartDTO();
		cart.setCart_no(cart_no);
		
		//System.out.println(cartDao.countUp(cart));
		
		return cartDao.countUp(cart);
	}//countUp() end
	
		
//----------------------------------------------------------- [장바구니 수량 감소]	
	@RequestMapping("/cart/countDown")
	@ResponseBody
	private int countDown(@RequestParam int cart_no) throws Exception {
		
		CartDTO cart = new CartDTO();
		cart.setCart_no(cart_no);
		
		//System.out.println(cartDao.countDown(cart));
		
		return cartDao.countDown(cart);
	}//countUp() end
	
//----------------------------------------------------------- [장바구니 삭제]	
	@RequestMapping("/cart/deleteMycart")
	@ResponseBody
	private int deleteMycart(@RequestParam int cart_no) throws Exception {
		
		CartDTO cart = new CartDTO();
		cart.setCart_no(cart_no);
		
		//System.out.println(cartDao.countDown(cart));
		
		return cartDao.deleteMycart(cart);
	}//countUp() end
	
//----------------------------------------------------------- [장바구니 선택 삭제]	
	@RequestMapping(value="/cart/selectDelete", method = RequestMethod.POST )
	@ResponseBody
	private int selectDelMycart(@RequestParam Map<String, Object> parameters) throws Exception {
		
		
		
		 /* chkList로 넘어온 데이터를 문자열로 변환 */
	      String chkArray = parameters.get("chkList").toString();
	      
	      //System.out.println(chkArray);
		
	     // 배열 [] 기호 삭제
	      chkArray = chkArray.substring(1, (chkArray.length()- 1));
	      
	      // " 기호 삭제
	      chkArray = chkArray.replace("\"","");
	      
	      // ,단위로 문자열 분해 후 배열에 담기
	      String [] chkList = chkArray.split(","); 
	      
	      // 배열을 List로 변환
	      List list = Arrays.asList(chkList);
		
	      CartDTO dto = new CartDTO();
	      dto.setChkList(list);
	      
		
		return cartDao.selectDelete(dto);
	}//selectDelMycart() end
	
	
//----------------------------------------------------------- [장바구니에서 결제하기로 이동]	
	@RequestMapping(value="/cart/cartOrder", method = RequestMethod.POST)
	public ModelAndView cartOrder(HttpServletRequest req, HttpSession session){
		
		ModelAndView mav = new ModelAndView();
		
		String m_id = (String) session.getAttribute("s_m_id");

		
		mav.setViewName("/cart/cartOrder");

	    mav.addObject("mycart", cartDao.mycartList(m_id));
	
		return mav;
	}
	
}//class end
