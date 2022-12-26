package kr.co.itwill.cart;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
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

import kr.co.itwill.memberGeneral.MemberGeneralDTO;
import kr.co.itwill.memberSeller.SellerProductDTO;
import kr.co.itwill.orderDetail.OrderDetailDTO;
import kr.co.itwill.product.ProductDAO;

@Controller
public class CartCont {
	
	public CartCont() {
		System.out.println("------- CartCont() 객체 생성됨 ");
	}// CartCont()

	
	@Autowired
	CartDAO cartDao;
	
	@Autowired
	ProductDAO productDao;



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
        mav.addObject("mycartCnt", cartDao.mycartCnt(m_id));
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
	public ModelAndView cartOrder(HttpServletRequest req, HttpSession session) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		String m_id = (String) session.getAttribute("s_m_id");
		if( !(m_id == null) ) {
			
			String[] arrayParam = req.getParameterValues("cartno");
	        /*  
		    for (int i = 0; i < arrayParam.length; i++) {
	              System.out.println(arrayParam[i]);
	          }
	       */
	        // 배열을 List로 변환
	        List list = Arrays.asList(arrayParam);
	        
	        CartDTO dto = new CartDTO();
	        dto.setChkList(list);
	        dto.setM_id(m_id);
			
			mav.setViewName("/cart/cartOrder");
			mav.addObject("cartorder",cartDao.cartorder(dto));
			mav.addObject("cart_orderPrice", cartDao.cart_orderPrice(dto));
			mav.addObject("order_Minfo",productDao.order_Minfo(m_id));				// 구매자 정보 
			mav.addObject("mem_cou", cartDao.mem_cou(dto));							// 구매자 해당 상품에 사용 가능 쿠폰리스트 
			mav.addObject("mem_couCNT", cartDao.mem_couCNT(dto));					// 구매자 해당 상품에 사용 가능한 쿠폰 수량
			mav.addObject("mem_couponTOTALCNT",productDao.mem_couponTOTALCNT(m_id));// 구매자 사용 가능 쿠폰 총 수량
		
			return mav;
			
		}else {
			mav.setViewName("/memberGeneral/alert"); //알림페이지로 이동
			mav.addObject("msg", "로그인이 필요합니다.");
			mav.addObject("url", "/loginForm"); //로그인 폼 url명령어 입력
			
			return mav;
		}//if end
		
	}//end
	
	@ResponseBody
	@RequestMapping(value = "/cart/detailcoupon", method = RequestMethod.POST)
	public List<Map<String, Object>> detailcoupon (@RequestParam int cp_no){
		//System.out.println("cp_no" + cp_no);
		return cartDao.detailcoupon(cp_no);
	}//end
	
	
	
	@RequestMapping("/cart/cartOrderProc")
	public ModelAndView cartorderProc (  HttpServletRequest req
									 	,HttpSession session
									 	//,@ModelAttribute OrderDetailDTO dto
									 	) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		//System.out.println("***");
		
		String m_id=(String)session.getAttribute("s_m_id");

		if(m_id!=null) { // 로그인상태일때
			
			Map<String, Object> map = new HashMap<>();
			
			//order_num
			//주문서 일련번호 만들기
			//현재 날짜+시간
			LocalDateTime now = LocalDateTime.now();
			//System.out.println(now); //2022-12-13T11:34:14.726128
			//포맷팅
			String formatedIssueDate = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	        String formatedNow = now.format(DateTimeFormatter.ofPattern("yyyyMMdd-HHmmssSS"));
			//System.out.println(formatedNow); //20221213-14233419
	        //dto.setOrder_num(formatedNow);

	        map.put("order_num", formatedNow);

	        if (Integer.parseInt(req.getParameter("cp_no")) == 0) {
	        	
	        }else {	//쿠폰 사용시 
	        	//int cp_no = Integer.parseInt(req.getParameter("cp_no"));
	        	map.put("cp_no", req.getParameter("cp_no"));
	        	
	        	// 쿠폰 사용여부 업데이트 
	        	int cpstusup = productDao.cpstusUp(Integer.parseInt(req.getParameter("cp_no")));
	        	//System.out.println("cpstusup"+cpstusup);
	        }
	        
	        // ProductOrder 인서트 
	        map.put("m_id", m_id);
	        map.put("order_price", req.getParameter("order_price"));
	        map.put("cp_dis", req.getParameter("cp_dis"));
	        map.put("pt_minus", req.getParameter("pt_minus"));
	        map.put("d_fee", req.getParameter("d_fee"));
	        map.put("total_price", req.getParameter("total_price"));
	        map.put("rec_name", req.getParameter("rec_name"));
	        map.put("rec_tel", req.getParameter("rec_tel"));
	        map.put("rec_addr1", req.getParameter("rec_addr1"));
	        map.put("rec_addr2", req.getParameter("rec_addr2"));
	        map.put("rec_zipcode", req.getParameter("rec_zipcode"));
	        map.put("msg", req.getParameter("msg"));
	        map.put("pt_plus", req.getParameter("pt_plus"));
	  
			int ProductOrdercnt = productDao.productorderIns(map);
			//System.out.println("ProductOrdercnt "+ProductOrdercnt);
			
			
			// OrderDetail 인서트 
			String[] prono = req.getParameterValues("prono");
			String[] detail_cnt = req.getParameterValues("detail_cnt");
			String[] org_price = req.getParameterValues("org_price");
			//String[] discount = req.getParameterValues("discount");
	        /*
		    for (int i = 0; i < discount.length; i++) {
	              System.out.println(discount[i]);
	          }
		   */
	        // 배열을 List로 변환
	        List<OrderDetailDTO> orderdetail = new ArrayList<>();
	        
	        for(int i=0; i<prono.length; i++){
	        	OrderDetailDTO dto = new OrderDetailDTO();
	        	
	        	dto.setPro_no(Integer.parseInt(prono[i]));
	        	dto.setDetail_cnt(Integer.parseInt(detail_cnt[i]));
	        	dto.setOrg_price(Integer.parseInt(org_price[i]));
	        	dto.setOrder_num(formatedNow);
	        	//dto.setDiscount(Integer.parseInt(discount[i]));
	        	//dto.setPricesum(Integer.parseInt(org_price[i])-Integer.parseInt(discount[i]));
	        	dto.setStus("상품준비중");
	        	
	        	orderdetail.add(dto);
	        }//for end
	        
	        int odtest = cartDao.cart_orderDtail(orderdetail);

			
			MemberGeneralDTO dtoMG = new MemberGeneralDTO();
			dtoMG = productDao.holdingpoint(m_id);
			int holdingpoint = dtoMG.getPoint();							// 보유 포인트 
			int pt_minus = Integer.parseInt(req.getParameter("pt_minus"));	// 사용 포인트
			int pt_plus = Integer.parseInt(req.getParameter("pt_plus"));	// 적립금
			
			
			// member - point 업데이트 
			Map<String, Object> mempointmap = new HashMap<>();
			int newpoint = 0;
			
			if(pt_minus > 0) {
				newpoint = holdingpoint - pt_minus;
				newpoint += pt_plus;
			}else {
				newpoint = holdingpoint + pt_plus;
			}
			
			mempointmap.put("m_id", m_id);
			mempointmap.put("point", newpoint);
			
			int mempointUpdate = productDao.mempointUp(mempointmap);
			//System.out.println("mempointUpdate "+mempointUpdate);
			
			// PointDetail
			if ( pt_minus > 0 ) {	
				// 포인트 사용시 차감 인서트			 
				int pt_total = holdingpoint - pt_minus;
				
				Map<String, Object> pointminusmap = new HashMap<>();
				pointminusmap.put("m_id", m_id);
				pointminusmap.put("pt_minus", pt_minus);
				pointminusmap.put("pt_total", pt_total);
				pointminusmap.put("order_num", formatedNow);
			
				int PointMinuscnt = productDao.pointminusIns(pointminusmap);
				//System.out.println("PointMinuscnt "+PointMinuscnt);
			}//if end
			
			// 포인트 적립 인서트	
			Map<String, Object> pointplusmap = new HashMap<>();
			pointplusmap.put("m_id", m_id);
			pointplusmap.put("pt_plus", pt_plus);
			pointplusmap.put("pt_total", newpoint);
			pointplusmap.put("order_num", formatedNow);
			
			int PointPluscnt = productDao.pointplusIns(pointplusmap);
			//System.out.println("PointPluscnt "+PointPluscnt);
			
			// 장바구니 비우기
			String[] cart_no = req.getParameterValues("cart_no");
			List cartnoDel = Arrays.asList(cart_no);
			
			int cartnoDelcnt = cartDao.cartdel(cartnoDel);
			//System.out.println("cartnoDelcnt"+cartnoDelcnt);
			
			
			mav.setViewName("/product/orderSucc");
			
			return mav;
		
		}else {			 // 로그아웃상태일때
			mav.setViewName("/memberGeneral/alert"); //알림페이지로 이동
			mav.addObject("msg", "로그인이 필요합니다");
			mav.addObject("url", "/loginForm"); //로그인 폼 url명령어 입력
			
			return mav;
		
		}//if end
	}//end 
	
}//class end
