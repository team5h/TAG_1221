 package kr.co.itwill.product;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import kr.co.itwill.QnA.QnADTO;

import kr.co.itwill.concert.ConcertDTO;
import kr.co.itwill.mylike.MylikeDAO;
import kr.co.itwill.orderDetail.OrderDetailDTO;
import kr.co.itwill.productOrder.ProdcutOrderDTO;

@Controller
public class ProductCont {

	public ProductCont() {
		System.out.println("------- ProductCont() 객체 생성됨 ");
	}//ProductCont() end
	
	@Autowired
	ProductDAO productDao;
	
	
//  [상품리스트 - 전체보기] 시작 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  //
	

    @RequestMapping("/list.do")
    public ModelAndView list(HttpServletRequest req, HttpSession session) {
    	
    	//System.out.println(req.getParameter("category"));
    	String category = req.getParameter("category");// A C M P
    	String m_id = (String)session.getAttribute("s_m_id");
    	
    	
        ModelAndView mav = new ModelAndView();
        mav.setViewName("product/list");
        
        int totalRowCount = 0;
        if(category==null) {
        	totalRowCount = productDao.total(); // 카테고리 전체 총 글갯수
        }else {
        	totalRowCount = productDao.categoryTotal(category); // 카테고리별 글 개수
        }//if end
        
        // 페이징 파트
        int numPerPage = 9; // 한 페이지당 레코드(글) 갯수
        int pagePerBlock = 5; // 페이지 리스트 (블럭당 페이지 수)

        // 현재 페이지 번호 (문자형)
        String pageNum = req.getParameter("pageNum");
        //System.out.println(pageNum);
        
        if (pageNum == null) {
            pageNum = "1";
        } // if end

        int currentPage = Integer.parseInt(pageNum);
        int startRow = (currentPage - 1) * numPerPage + 1;
        int endRow = currentPage * numPerPage;
        double totcnt = (double) totalRowCount / numPerPage;
        int totalPage = (int) Math.ceil(totcnt);
        double d_page = (double) currentPage / pagePerBlock;
        int Pages = (int)Math.ceil(d_page)-1;
        int startPage = Pages * pagePerBlock+1;
        int endPage = startPage + pagePerBlock-1;
        
        List list = null;
        if (totalRowCount > 0) {
        	if (category==null) {
        		list = productDao.list(startRow, endRow);
        		//System.out.println(productDao.list(startRow, endRow));
        	}else {
                list = productDao.list2(startRow, endRow, category);//1, 5, M
                //System.out.println(productDao.list2(startRow, endRow, category));
        	}
        } else {
            list = Collections.emptyList(); // 안 넣어도 상관 없음
        } // if end
    	
        //System.out.println(productDao.list(startRow, endRow));
        
 	    mav.addObject("total", totalRowCount);
 	    mav.addObject("category", category);
 	    mav.addObject("categoryAll", productDao.categoryAll());
        mav.addObject("list", list);
        mav.addObject("pageNum", currentPage);

        mav.addObject("count", totalRowCount);
        mav.addObject("totalPage", totalPage);
        mav.addObject("startPage", startPage);
        mav.addObject("endPage", endPage);
        mav.addObject("orderby", "r");
        
        mav.addObject("like", productDao.mem_like(m_id));
        //System.out.println(productDao.mem_like(m_id));
        
        return mav;
        
    }//list() end
    
    
    
 // [상품리스트 - 콘서트 카테고리] - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	
 	@RequestMapping("/listConcert")
 	public ModelAndView concertList(HttpServletRequest req, HttpSession session) {
 		//System.out.println("잘 도착 했다.");
 		
 		String c_no = req.getParameter("c_no");
 		//System.out.println(c_no);
 		String m_id = (String)session.getAttribute("s_m_id");
 		
 		ModelAndView mav = new ModelAndView();
 		mav.setViewName("product/listConcert");
 		
 		int totalRowCount = productDao.concertTotal(c_no);
 		//System.out.println(totalRowCount);
 		
 		
        // 페이징 파트
        int numPerPage = 9; // 한 페이지당 레코드(글) 갯수
        int pagePerBlock = 5; // 페이지 리스트 (블럭당 페이지 수)

        // 현재 페이지 번호 (문자형)
        String pageNum = req.getParameter("pageNum");
        //System.out.println(pageNum);
        
        if (pageNum == null) {
            pageNum = "1";
        } // if end

        int currentPage = Integer.parseInt(pageNum);
        int startRow = (currentPage - 1) * numPerPage + 1;
        int endRow = currentPage * numPerPage;
        double totcnt = (double) totalRowCount / numPerPage;
        int totalPage = (int) Math.ceil(totcnt);
        double d_page = (double) currentPage / pagePerBlock;
        int Pages = (int)Math.ceil(d_page)-1;
        int startPage = Pages * pagePerBlock+1;
        int endPage = startPage + pagePerBlock-1;
        
        List list = null;
        if (totalRowCount > 0) {
        	list = productDao.concertList(startRow, endRow, c_no);//1, 5, M
        } else {
            list = Collections.emptyList(); // 안 넣어도 상관 없음
        } // if end
    	
 	    mav.addObject("total", totalRowCount);
 	    mav.addObject("c_no", c_no);
 	    mav.addObject("categoryAll", productDao.categoryAll());
        mav.addObject("list", list);
        mav.addObject("pageNum", currentPage);

        mav.addObject("count", totalRowCount);
        mav.addObject("totalPage", totalPage);
        mav.addObject("startPage", startPage);
        mav.addObject("endPage", endPage);
 	
 		
 		mav.addObject("categoryAll", productDao.categoryAll());
 		mav.addObject("concertlist", productDao.concert());
 		
 		//System.out.println("컨트롤러 확인" + productDao.concert());
 		//System.out.println(productDao.list());
 		mav.addObject("orderby", "r");
 		mav.addObject("like", productDao.mem_like(m_id));
 		
 		return mav;
 	}//listConcert() end    
 	

    
//  [상품검색] 시작  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  //
    
	@RequestMapping("/search")
	public ModelAndView search(@RequestParam(defaultValue = "") String pro_name) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("product/list");
		mav.addObject("list", productDao.search(pro_name));
		
		mav.addObject("pro_name", pro_name);
		
		return mav;
	}//search() end

	

//  [상품리스트 - 음반 카테고리] 시작  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    
	@RequestMapping("/music")
    public ModelAndView music(String category) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("product/list");
		
		System.out.println(category);
   
	    return mav;
	}//search() end	
	
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //

	
	@RequestMapping("/product/{pro_no}")
	public ModelAndView productdetail(@PathVariable int pro_no, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		String m_id = (String)session.getAttribute("s_m_id");
		
		mav.setViewName("/product/detail");
		//System.out.println(pro_no);
		mav.addObject("proDetail", productDao.proDetail(pro_no));
		mav.addObject("pro_qnacnt",productDao.pro_qnacnt(pro_no));
		mav.addObject("qnalist",productDao.qnalist(pro_no));
		
		if(!(m_id == null)) {
			mav.addObject("likechk", productDao.likechk(m_id, pro_no));
		} 
		
		return mav;
	}// end
	
	@ResponseBody
	@RequestMapping(value = "/product/qnainsert", method = RequestMethod.POST)
	public int qnainsert(@ModelAttribute QnADTO dto) {
		return productDao.qnainsert(dto);
	}//end
	
	@ResponseBody
	@RequestMapping(value = "/product/qnadetail", method = RequestMethod.POST)
	public Map<String, Object> qnadetail(@RequestParam int q_no, @RequestParam int passwd) {		
		Map<String, Object> map = new HashMap<String, Object>();
		
		QnADTO dto = productDao.qnadetail(q_no, passwd); 

		map.put("subject", dto.getSubject());
		map.put("edit", dto.getEdit());
		map.put("content", dto.getContent());
		map.put("regdate", dto.getRegdate());
		
		return map;
	}//end
	
	@ResponseBody
	@RequestMapping(value = "/product/addcart", method = RequestMethod.POST)
	public int addcart(@RequestParam int cnt, @RequestParam int pro_no, @RequestParam String m_id) {
		return productDao.addcart(cnt, pro_no, m_id);
	}
	
	@ResponseBody
	@RequestMapping(value = "/product/like", method = RequestMethod.POST)
	public int like(@RequestParam int pro_no, @RequestParam String m_id) {
		return productDao.like(pro_no, m_id);
	}
	
	@ResponseBody
	@RequestMapping(value = "/product/unlike", method = RequestMethod.POST)
	public int unlike(@RequestParam int pro_no, @RequestParam String m_id) {
		return productDao.unlike(pro_no, m_id);
	}	
	
	//order - payment
	
	@RequestMapping("/product/order")
	public ModelAndView order(int pro_no, String m_id, int buystock){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/product/order");
		
		mav.addObject("order_proinfo",productDao.order_proinfo(pro_no));		// 상품정보
		mav.addObject("order_Minfo",productDao.order_Minfo(m_id));				// 구매자
		mav.addObject("buystock",buystock);										// 구매 수량
		mav.addObject("mem_coupon",productDao.mem_coupon(pro_no, m_id));		// 구매자 해당 상품에 사용 가능 쿠폰리스트 
		mav.addObject("mem_couponCNT",productDao.mem_couponCNT(pro_no,m_id));	// 구매자 해당 상품에 사용 가능한 쿠폰 수량
		mav.addObject("mem_couponTOTALCNT",productDao.mem_couponTOTALCNT(m_id));// 구매자 사용 가능 쿠폰 총 수량

		return mav;
	}//end
	
	@RequestMapping("/product/orderProc")
	public ModelAndView orderSucc ( //@RequestParam Map<String, Object> map
									@ModelAttribute OrderDetailDTO dto
									, HttpServletRequest req 
								    , HttpSession session) throws Exception {
		//System.out.println("--");
		
		ModelAndView mav = new ModelAndView();
		
		String m_id=(String)session.getAttribute("s_m_id");

		if(m_id!=null) { //session아이디를 불러왔다면
			
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
	        	
	        }else {
	        	map.put("cp_no", req.getParameter("cp_no"));
	        }
	        
	        // ProductOrder
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
	        
			int cnt = productDao.productorderIns(map);
			//System.out.println(cnt);

			// OrderDetail
			dto.setOrder_num(formatedNow);
			
			int org_price = Integer.parseInt(req.getParameter("order_price"));
			int pricesum = org_price - Integer.parseInt(req.getParameter("discount"));
			dto.setOrg_price(org_price);
			dto.setPricesum(pricesum);
			
			int cnt2 = productDao.orderdetailIns(dto);
			//System.out.println(cnt2);
			
			
			// PointDetail
			
			
			
			mav.setViewName("/product/orderSucc");
			
			return mav;
		}else { //session아이디를 불러오지 못했다면
			mav.setViewName("/memberGeneral/alert"); //알림페이지로 이동
			mav.addObject("msg", "로그인이 필요합니다");
			mav.addObject("url", "/loginForm"); //로그인 폼 url명령어 입력
			
			return mav;
		}
	}//end
	
	
// ------------------------------------------------------------------------- member_like 좋아요 추가
	@ResponseBody
	@RequestMapping(value = "/product/likeInsert", method = RequestMethod.POST)
	public int likeInsert(@RequestParam int pro_no, @RequestParam String m_id) {
		return productDao.like(pro_no, m_id);
	}//likeInsert end
	
// ------------------------------------------------------------------------- member_like 좋아요 삭제
	@ResponseBody
	@RequestMapping(value = "/product/likeDec", method = RequestMethod.POST)
	public int likeDec(@RequestParam int pro_no, @RequestParam String m_id) {
		return productDao.unlike(pro_no, m_id);
	}//likeDec end
	
	
// ------------------------------------------------------------------------- 상품 좋아요 + 1	
	@RequestMapping("/product/likecntInc")
	@ResponseBody
	private int likecntInc(@RequestParam int pro_no) throws Exception {
		
		
		ProductDTO product = new ProductDTO();
		product.setPro_no(pro_no);
		
		//System.out.println("DTO concert 값" + concertDao.likecntUpdate(concert));
		return productDao.likecntInc(product);
		
	}//likecntInsert end
	
	
// ------------------------------------------------------------------------- 상품 좋아요 - 1	
	@RequestMapping("/product/likecntDec")
	@ResponseBody
	private int likecnDec(@RequestParam int pro_no) throws Exception {
		
		
		ProductDTO product = new ProductDTO();
		product.setPro_no(pro_no);
		
		//System.out.println("DTO concert 값" + concertDao.likecntUpdate(concert));
		return productDao.likecntDec(product);
		
	}//likecntInsert end
	
	
	
// ------------------------------------------------------------------------- 상품 All 인기순
	@RequestMapping("/list.do/popularAll")
	public ModelAndView allPopular(HttpServletRequest req, HttpSession session) {
		
		String category = req.getParameter("category");// A C M P
		String m_id = (String)session.getAttribute("s_m_id");
		
		ModelAndView mav = new ModelAndView();
        mav.setViewName("product/list");
        
		int totalRowCount = productDao.total();
 		//System.out.println(totalRowCount);
 		
 		
        // 페이징 파트
        int numPerPage = 9; // 한 페이지당 레코드(글) 갯수
        int pagePerBlock = 5; // 페이지 리스트 (블럭당 페이지 수)

        // 현재 페이지 번호 (문자형)
        String pageNum = req.getParameter("pageNum");
        //System.out.println(pageNum);
        
        if (pageNum == null) {
            pageNum = "1";
        } // if end

        int currentPage = Integer.parseInt(pageNum);
        int startRow = (currentPage - 1) * numPerPage + 1;
        int endRow = currentPage * numPerPage;
        double totcnt = (double) totalRowCount / numPerPage;
        int totalPage = (int) Math.ceil(totcnt);
        double d_page = (double) currentPage / pagePerBlock;
        int Pages = (int)Math.ceil(d_page)-1;
        int startPage = Pages * pagePerBlock+1;
        int endPage = startPage + pagePerBlock-1;
        
        List list = null;
        if (totalRowCount > 0) {
        	list = productDao.popularAll(startRow, endRow);//1, 5, M
        } else {
            list = Collections.emptyList(); // 안 넣어도 상관 없음
        } // if end
    	
 	    mav.addObject("total", totalRowCount);
 	    mav.addObject("categoryAll", productDao.categoryAll());
 	    mav.addObject("list", list);
        mav.addObject("pageNum", currentPage);

        mav.addObject("count", totalRowCount);
        mav.addObject("totalPage", totalPage);
        mav.addObject("startPage", startPage);
        mav.addObject("endPage", endPage);
        mav.addObject("like", productDao.mem_like(m_id));
        mav.addObject("orderby", "p");
		
		return mav;
		
	}//likecntInsert end
	
	
	
// ------------------------------------------------------------------------- 상품 All 인기순
	@RequestMapping("/list.do/likeAll")
	public ModelAndView likeAll(HttpServletRequest req, HttpSession session) {
		
		
		String category = req.getParameter("category");// A C M P
		String m_id = (String)session.getAttribute("s_m_id");
		
		ModelAndView mav = new ModelAndView();
        mav.setViewName("product/list");
        
		int totalRowCount = productDao.total();
 		//System.out.println(totalRowCount);
 		
 		
        // 페이징 파트
        int numPerPage = 9; // 한 페이지당 레코드(글) 갯수
        int pagePerBlock = 5; // 페이지 리스트 (블럭당 페이지 수)

        // 현재 페이지 번호 (문자형)
        String pageNum = req.getParameter("pageNum");
        //System.out.println(pageNum);
        
        if (pageNum == null) {
            pageNum = "1";
        } // if end

        int currentPage = Integer.parseInt(pageNum);
        int startRow = (currentPage - 1) * numPerPage + 1;
        int endRow = currentPage * numPerPage;
        double totcnt = (double) totalRowCount / numPerPage;
        int totalPage = (int) Math.ceil(totcnt);
        double d_page = (double) currentPage / pagePerBlock;
        int Pages = (int)Math.ceil(d_page)-1;
        int startPage = Pages * pagePerBlock+1;
        int endPage = startPage + pagePerBlock-1;
        
        List list = null;
        if (totalRowCount > 0) {
        	list = productDao.likeAll(startRow, endRow);//1, 5, M
        } else {
            list = Collections.emptyList(); // 안 넣어도 상관 없음
        } // if end
    	
 	    mav.addObject("total", totalRowCount);
 	    mav.addObject("categoryAll", productDao.categoryAll());
 	    mav.addObject("list", list);
        mav.addObject("pageNum", currentPage);

        mav.addObject("count", totalRowCount);
        mav.addObject("totalPage", totalPage);
        mav.addObject("startPage", startPage);
        mav.addObject("endPage", endPage);

        mav.addObject("orderby", "l");
		
		return mav;
		
	}//likecntInsert end
	
	
// ------------------------------------------------------------------------- 상품 콘서트 카테고리 인기순
	
 	@RequestMapping("/listConcert/popularCon")
 	public ModelAndView popularCon(HttpServletRequest req, HttpSession session) {
 		//System.out.println("잘 도착 했다.");
 		
 		String c_no = req.getParameter("c_no");
 		//System.out.println(c_no);
 		String m_id = (String)session.getAttribute("s_m_id");
 		
 		ModelAndView mav = new ModelAndView();
 		mav.setViewName("product/listConcert");
 		
 		int totalRowCount = productDao.concertTotal(c_no);
 		//System.out.println(totalRowCount);
 		
 		
        // 페이징 파트
        int numPerPage = 9; // 한 페이지당 레코드(글) 갯수
        int pagePerBlock = 5; // 페이지 리스트 (블럭당 페이지 수)

        // 현재 페이지 번호 (문자형)
        String pageNum = req.getParameter("pageNum");
        //System.out.println(pageNum);
        
        if (pageNum == null) {
            pageNum = "1";
        } // if end

        int currentPage = Integer.parseInt(pageNum);
        int startRow = (currentPage - 1) * numPerPage + 1;
        int endRow = currentPage * numPerPage;
        double totcnt = (double) totalRowCount / numPerPage;
        int totalPage = (int) Math.ceil(totcnt);
        double d_page = (double) currentPage / pagePerBlock;
        int Pages = (int)Math.ceil(d_page)-1;
        int startPage = Pages * pagePerBlock+1;
        int endPage = startPage + pagePerBlock-1;
        
        List list = null;
        if (totalRowCount > 0) {
        	list = productDao.popularCon(startRow, endRow, c_no);//1, 5, M
        } else {
            list = Collections.emptyList(); // 안 넣어도 상관 없음
        } // if end
    	
 	    mav.addObject("total", totalRowCount);
 	    mav.addObject("c_no", c_no);
 	    mav.addObject("categoryAll", productDao.categoryAll());
        mav.addObject("list", list);
        mav.addObject("pageNum", currentPage);

        mav.addObject("count", totalRowCount);
        mav.addObject("totalPage", totalPage);
        mav.addObject("startPage", startPage);
        mav.addObject("endPage", endPage);
 	
 		
 		mav.addObject("categoryAll", productDao.categoryAll());
 		mav.addObject("concertlist", productDao.concert());
 		
 		mav.addObject("orderby", "p");
 		mav.addObject("like", productDao.mem_like(m_id));
 		
 		return mav;
 	}//listConcert() end    
 	
 	
 // ------------------------------------------------------------------------- 상품 콘서트 카테고리 인기순
	
  	@RequestMapping("/listConcert/likeCon")
  	public ModelAndView likeCon(HttpServletRequest req, HttpSession session) {
  		//System.out.println("잘 도착 했다.");
  		
  		String c_no = req.getParameter("c_no");
  		//System.out.println(c_no);
  		String m_id = (String)session.getAttribute("s_m_id");
  		
  		ModelAndView mav = new ModelAndView();
  		mav.setViewName("product/listConcert");
  		
  		int totalRowCount = productDao.concertTotal(c_no);
  		//System.out.println(totalRowCount);
  		
  		
         // 페이징 파트
         int numPerPage = 9; // 한 페이지당 레코드(글) 갯수
         int pagePerBlock = 5; // 페이지 리스트 (블럭당 페이지 수)

         // 현재 페이지 번호 (문자형)
         String pageNum = req.getParameter("pageNum");
         //System.out.println(pageNum);
         
         if (pageNum == null) {
             pageNum = "1";
         } // if end

         int currentPage = Integer.parseInt(pageNum);
         int startRow = (currentPage - 1) * numPerPage + 1;
         int endRow = currentPage * numPerPage;
         double totcnt = (double) totalRowCount / numPerPage;
         int totalPage = (int) Math.ceil(totcnt);
         double d_page = (double) currentPage / pagePerBlock;
         int Pages = (int)Math.ceil(d_page)-1;
         int startPage = Pages * pagePerBlock+1;
         int endPage = startPage + pagePerBlock-1;
         
         List list = null;
         if (totalRowCount > 0) {
         	list = productDao.likeCon(startRow, endRow, c_no);//1, 5, M
         } else {
             list = Collections.emptyList(); // 안 넣어도 상관 없음
         } // if end
     	
  	    mav.addObject("total", totalRowCount);
  	    mav.addObject("c_no", c_no);
  	    mav.addObject("categoryAll", productDao.categoryAll());
         mav.addObject("list", list);
         mav.addObject("pageNum", currentPage);

         mav.addObject("count", totalRowCount);
         mav.addObject("totalPage", totalPage);
         mav.addObject("startPage", startPage);
         mav.addObject("endPage", endPage);
  	
  		
  		mav.addObject("categoryAll", productDao.categoryAll());
  		mav.addObject("concertlist", productDao.concert());
  		
  		mav.addObject("orderby", "l");
  		mav.addObject("like", productDao.mem_like(m_id));
  		
  		return mav;
  	}//listConcert() end 
 	
	
 // [상품리스트 - 콘서트 카테고리 인기순] - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	
  	 @RequestMapping("/list.do/popularCateg")
     public ModelAndView popularCateg(HttpServletRequest req, HttpSession session) {
     	
     	//System.out.println(req.getParameter("category"));
     	String category = req.getParameter("category");// A C M P
     	String m_id = (String)session.getAttribute("s_m_id");
     	
     	
         ModelAndView mav = new ModelAndView();
         mav.setViewName("/product/list");
         
         int totalRowCount = productDao.categoryTotal(category); // 카테고리별 글 개수
         
         // 페이징 파트
         int numPerPage = 9; // 한 페이지당 레코드(글) 갯수
         int pagePerBlock = 5; // 페이지 리스트 (블럭당 페이지 수)

         // 현재 페이지 번호 (문자형)
         String pageNum = req.getParameter("pageNum");
         //System.out.println(pageNum);
         
         if (pageNum == null) {
             pageNum = "1";
         } // if end

         int currentPage = Integer.parseInt(pageNum);
         int startRow = (currentPage - 1) * numPerPage + 1;
         int endRow = currentPage * numPerPage;
         double totcnt = (double) totalRowCount / numPerPage;
         int totalPage = (int) Math.ceil(totcnt);
         double d_page = (double) currentPage / pagePerBlock;
         int Pages = (int)Math.ceil(d_page)-1;
         int startPage = Pages * pagePerBlock+1;
         int endPage = startPage + pagePerBlock-1;
         
         List list = null;
         if (totalRowCount > 0) {
        	 list = productDao.popularCateg(startRow, endRow, category);//1, 5, M
                 //System.out.println(productDao.list2(startRow, endRow, category));
         } else {
             list = Collections.emptyList(); // 안 넣어도 상관 없음
         } // if end
     	
         //System.out.println(productDao.list(startRow, endRow));
         
  	    mav.addObject("total", totalRowCount);
  	    mav.addObject("category", category);
  	    mav.addObject("categoryAll", productDao.categoryAll());
         mav.addObject("list", list);
         mav.addObject("pageNum", currentPage);

         mav.addObject("count", totalRowCount);
         mav.addObject("totalPage", totalPage);
         mav.addObject("startPage", startPage);
         mav.addObject("endPage", endPage);
         mav.addObject("orderby", "p");
         
         mav.addObject("like", productDao.mem_like(m_id));
         //System.out.println(productDao.mem_like(m_id));
         
         return mav;
         
     }//list() end
 	
 	
 // [상품리스트 - 콘서트 카테고리] - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	
 	 @RequestMapping("/list.do/likeCateg")
     public ModelAndView likeCateg(HttpServletRequest req, HttpSession session) {
     	
     	//System.out.println(req.getParameter("category"));
     	String category = req.getParameter("category");// A C M P
     	String m_id = (String)session.getAttribute("s_m_id");
     	
     	
         ModelAndView mav = new ModelAndView();
         mav.setViewName("product/list");
         
         int totalRowCount = 0;
         if(category==null) {
         	totalRowCount = productDao.total(); // 카테고리 전체 총 글갯수
         }else {
         	totalRowCount = productDao.categoryTotal(category); // 카테고리별 글 개수
         }//if end
         
         // 페이징 파트
         int numPerPage = 9; // 한 페이지당 레코드(글) 갯수
         int pagePerBlock = 5; // 페이지 리스트 (블럭당 페이지 수)

         // 현재 페이지 번호 (문자형)
         String pageNum = req.getParameter("pageNum");
         //System.out.println(pageNum);
         
         if (pageNum == null) {
             pageNum = "1";
         } // if end

         int currentPage = Integer.parseInt(pageNum);
         int startRow = (currentPage - 1) * numPerPage + 1;
         int endRow = currentPage * numPerPage;
         double totcnt = (double) totalRowCount / numPerPage;
         int totalPage = (int) Math.ceil(totcnt);
         double d_page = (double) currentPage / pagePerBlock;
         int Pages = (int)Math.ceil(d_page)-1;
         int startPage = Pages * pagePerBlock+1;
         int endPage = startPage + pagePerBlock-1;
         
         List list = null;
         if (totalRowCount > 0) {
         	if (category==null) {
         		list = productDao.list(startRow, endRow);
         		//System.out.println(productDao.list(startRow, endRow));
         	}else {
                 list = productDao.likeCateg(startRow, endRow, category);//1, 5, M
                 //System.out.println(productDao.list2(startRow, endRow, category));
         	}
         } else {
             list = Collections.emptyList(); // 안 넣어도 상관 없음
         } // if end
     	
         //System.out.println(productDao.list(startRow, endRow));
         
  	    mav.addObject("total", totalRowCount);
  	    mav.addObject("category", category);
  	    mav.addObject("categoryAll", productDao.categoryAll());
         mav.addObject("list", list);
         mav.addObject("pageNum", currentPage);

         mav.addObject("count", totalRowCount);
         mav.addObject("totalPage", totalPage);
         mav.addObject("startPage", startPage);
         mav.addObject("endPage", endPage);
         mav.addObject("orderby", "l");
         
         mav.addObject("like", productDao.mem_like(m_id));
         //System.out.println(productDao.mem_like(m_id));
         
         return mav;
     }//list() end
 	
	
	
}//class end

