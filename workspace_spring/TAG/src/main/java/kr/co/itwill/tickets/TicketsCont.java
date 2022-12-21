package kr.co.itwill.tickets;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.co.itwill.coupon.CouponDTO;
import kr.co.itwill.mylike.MylikeDTO;
import kr.co.itwill.product.ProductDTO;

@Controller
public class TicketsCont {

	public TicketsCont() {
		System.out.println("--------TicketsCont() 객체 생성");
	}// default constructor
	
	
	/*
	@RequestMapping("/tickets")
	public String tickets() {
		return "/tickets/book";
	}//tickets() end
	
	@RequestMapping("map1F.do")
	public String map1F() {
		return "/tickets/map1F";
	}//map1F() end
	
	@RequestMapping("map2F.do")
	public String map2F() {
		return "/tickets/map2F";
	}//map2F() end
	
	@RequestMapping(value="seatAddForm.do", method = RequestMethod.GET)
	public String seatAddForm() {
		return "/tickets/seatAddForm";
	}//seatAddForm() end
	
	@RequestMapping("ticketSale.do")
	public String ticketSale() {
		return "/tickets/ticketSale";
	}//ticketSale() end
	
	@RequestMapping("ticketAddForm.do")
	public String ticketAddForm() {
		return "/tickets/ticketAddForm";
	}//ticketAddForm() end
	*/
	
	@Autowired
	TicketOrderDAO ticketOrderDao;
	
	@RequestMapping(value="/insert.do", method = RequestMethod.POST)
	public ModelAndView submit(	  @ModelAttribute TicketOrderDTO orderDto
									//, @ModelAttribute TicketDetailDTO detailDto
									, HttpServletRequest req
									//, @RequestParam Map<String, Object> map
									, HttpSession session
									){
		
		
		//mav생성
		ModelAndView mav=new ModelAndView();
		
		//Session 아이디 확인
		String s_m_id=(String)session.getAttribute("s_m_id");
		if(s_m_id!=null) { //session아이디를 불러왔다면
			orderDto.setM_id(s_m_id);
			//System.out.println("s_m_id있음 : "+s_m_id);
		}else {
			//orderDto.setM_id("아이디없음");
			//System.out.println("s_m_id없음 : "+s_m_id);
			mav.setViewName("/loginForm");
			return mav;
		}//if end
		
		//1. Ticket_Order 테이블 INSERT
		//주문서 일련번호 만들기
		//현재 날짜+시간
		LocalDateTime now = LocalDateTime.now();
		//System.out.println(now); //2022-12-13T11:34:14.726128
		//포맷팅
		String formatedIssueDate = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        String formatedNow = now.format(DateTimeFormatter.ofPattern("yyyyMMdd-HHmmssSS"));
		//System.out.println(formatedNow); //20221213-14233419
		orderDto.setTck_num(formatedNow);
		//detailDto.setTck_num(formatedNow);
		
		//ticketOrder 1줄 insert문
		int cnt = ticketOrderDao.add(orderDto);

		
		//3. Coupon_Detail 테이블 INSERT
		//날짜계산
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd"); //날짜 포멧	
		//String formatedIssueDate = simpleDate.format(now);
		
		Date time = new Date();	 //현재 날짜
		Calendar cal = Calendar.getInstance();	 //날짜 계산을 위해 Calendar 추상클래스 선언 getInstance()메소드 사용	
		cal.setTime(time);	
		cal.add(Calendar.DATE, 10);	//10일 더하기
		String formatedExpDate = simpleDate.format(cal.getTime());
		
		CouponDTO coupDto=new CouponDTO();
		coupDto.setM_id(orderDto.getM_id());
		coupDto.setIssue_date(formatedIssueDate);
		coupDto.setExp_date(formatedExpDate);
		coupDto.setC_no(orderDto.getC_no());
		
		//선예매 여부 받아오기
		int earlybird= Integer.parseInt(req.getParameter("earlybird"));
		//System.out.println("testEarlybird : "+earlybird); //0:선예매x 1:선예매o
		
		if(earlybird == 0) {
			coupDto.setCoupon("Bc"); //일반예매 할인
		}else if(earlybird == 1) {
			coupDto.setCoupon("EBc"); //얼리버드 할인
		}//if end
		
		int cnt3 = ticketOrderDao.addCoupon(coupDto);
		if(cnt3 == 1) {
			//System.out.println("성공");
			
		}else {
			//System.out.println("실패");
		}//if end
		
		
		//2. Ticket_Detail 테이블 INSERT
		//TicketDetail	데이터 가공
		//List<Map<String, Object>> insertList = new ArrayList<Map<String, Object>>();
		
		//basic04_web>webapp>form>08_ok.jsp 참고
		String[] cseatList=req.getParameterValues("cseat");
		String[] flagnumList=req.getParameterValues("flagnum");
		
		List<TicketDetailDTO> ticketDetail=new ArrayList<>();
		int Rprice = Integer.parseInt(req.getParameter("price")); //R석의 가격 가져오기
		
		for(int i=0; i<cseatList.length; i++) {
			int price = 0;
			//좌석등급을 좌석 이름에서 자르기
			String str = cseatList[i]; 
			String grade = str.substring(0,1);
			//System.out.println(grade); //R, R, R, S, S, A
			
			//MAP에 등급별 좌석가격 넣기
			if( grade.equals("R") ) {
				price = Rprice;
			}else if( grade.equals("S") ) {
				price = Rprice-11000;
			}else if( grade.equals("A") ) {
				price = Rprice-22000;
			}else {
				price=0;
				//System.out.println("일치하는 등급 없음!!");
			}//if end
			
			TicketDetailDTO dto=new TicketDetailDTO();
			dto.setTck_num(formatedNow);
			dto.setCseat(cseatList[i]);
			dto.setFlagnum(flagnumList[i]);
			dto.setPrice(price);
			
			//ticketOrderDao.addDetail(dto);
			
			ticketDetail.add(dto);
		}//for end
		
		int cnt2=ticketOrderDao.addDetail(ticketDetail);
		
		
		if(cnt == 1 && cnt2 >= 1 && cnt3 ==1) { //티켓주문서, 티켓상세내역서, 쿠폰발급 성공
			//System.out.println("modelAndView 접근성공");
			mav.setViewName("/tickets/bookSucc");
			mav.addObject("msg1", "모두 성공");
			mav.addObject("content1", orderDto.toString());
			mav.addObject("content2", coupDto.toString());
			mav.addObject("couponDetail", coupDto);
			//mav.addObject("content2", detailDto.toString());
		}else if(cnt == 1){ //티켓주문서만 성공
			mav.setViewName("/tickets/bookSucc");
			mav.addObject("msg1", "티켓 상세 내역서 실패");
		}else if(cnt2 >=1) { //티켓 상세 내역서만 성공
			mav.setViewName("/tickets/bookSucc");
			mav.addObject("msg1", "티켓 주문서 실패");
		}else {
			mav.setViewName("/tickets/bookSucc");
			mav.addObject("msg1", "모두 실패");
		}//if end
		
		
		//4. 상품 불러오기
		List list = null;
		
		List<ProductDTO> productList=ticketOrderDao.productList(orderDto.getC_no());
		mav.addObject("list", productList);
		
		//5. 공연 이름 불러오기
		String concertTitle = req.getParameter("title");
		//System.out.println("concertTitle = " + concertTitle);
		mav.addObject("concertTitle", concertTitle);
		
		/*
		Map<String, Object> map = new HashMap<>();
		//System.out.println(cseatList.length);
		for(int i=0; i<cseatList.length; i++) {
			
			//MAP에 예매 번호 넣기
			map.put("tck_num", formatedNow);
			
			//MAP에 좌석이름 넣기
			System.out.println(cseatList[i]);
			map.put("cseat", cseatList[i]);
			
			//좌석등급을 좌석 이름에서 자르기
			String str = cseatList[i]; 
			String grade = str.substring(0,1);
			//System.out.println(grade); //R, R, R, S, S, A
			
			//MAP에 등급별 좌석가격 넣기
			if( grade.equals("R") ) {
				map.put("price", 88000);
			}else if( grade.equals("S") ) {
				map.put("price", 77000);
			}else if( grade.equals("A") ) {
				map.put("price", 66000);
			}else {
				System.out.println("일치하는 등급 없음!!");
			}//if end
			
			insertList.add(map);
		}//for end
		//System.out.println(insertList);
		//ticketOrderDao.addDetail(insertList);
		*/
		
		
		return mav;
	}//submit() end
	
	
	
	@RequestMapping(value="/insertDBTest", method = RequestMethod.GET)
	public ModelAndView insertDBTest(     HttpServletRequest req
										, HttpSession session
										){
		//mav생성
		ModelAndView mav=new ModelAndView();
		TicketOrderDTO orderDto = new TicketOrderDTO();
		
		//Session 아이디 확인
		String s_m_id=(String)session.getAttribute("s_m_id");
		if(s_m_id!=null) { //session아이디를 불러왔다면
			orderDto.setM_id(s_m_id);
			//System.out.println("s_m_id있음 : "+s_m_id);
		}else {
			//orderDto.setM_id("아이디없음");
			//System.out.println("s_m_id없음 : "+s_m_id);
			mav.setViewName("/loginForm");
			return mav;
		}//if end
		
		//1. Ticket_Order 테이블 INSERT
		LocalDateTime now = LocalDateTime.now();
		//포맷팅
        String formatedNow = now.format(DateTimeFormatter.ofPattern("yyyyMMdd-HHmmssSS"));
		orderDto.setTck_num(formatedNow);
		
		orderDto.setC_no(1);
		orderDto.setCnt(255);
		orderDto.setOrder_price(500000);
		orderDto.setTotal_price(500000);
		orderDto.setRec_name("Testname");
		orderDto.setRec_tel("Testtel");
		orderDto.setStus("Teststus");
		
		//ticketOrder 1줄 insert문
		int cnt = ticketOrderDao.add(orderDto);
		
		List<TicketDetailDTO> addDetailTest=new ArrayList<>();
		
		for(int i=0; i<255; i++) {
			TicketDetailDTO dto=new TicketDetailDTO();
			dto.setTck_num(formatedNow);
			dto.setCseat("test"+i);
			dto.setFlagnum("B"+i);
			dto.setPrice(200);
			
			addDetailTest.add(dto);
		}//for end
		
		int cnt2=ticketOrderDao.addDetailTest(addDetailTest);
		
		if(cnt == 1 && cnt2>=1) {
			mav.setViewName("/memberGeneral/alert"); //알림페이지로 이동
			mav.addObject("msg", "데이터 추가 완료");
			mav.addObject("url", "/home"); //로그인 폼 url명령어 입력
			return mav;
		}else { 
			mav.setViewName("/memberGeneral/alert"); //알림페이지로 이동
			mav.addObject("msg", "데이터 추가 실패");
			mav.addObject("url", "/home"); //로그인 폼 url명령어 입력
			return mav;
		}//if end
	}//insertDBTest() end
	
	
	
	
	
	
}//class end
