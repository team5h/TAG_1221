package kr.co.itwill.myticket;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.co.itwill.tickets.TicketDetailDTO;


@Controller
public class MyticketCont {

	public MyticketCont() {
		System.out.println("-----MyticketCont() 객체생성됨");
	}//end
	
	
	@Autowired
	MyticketDAO myticketDao;
	
	@RequestMapping("mypage/myticket")
	public ModelAndView list(HttpServletRequest req, HttpSession session) {
		ModelAndView mav=new ModelAndView();
		
		//로그인 확인
		String s_m_id=(String)session.getAttribute("s_m_id");
		if(s_m_id!=null) { //session아이디를 불러왔다면
			mav.setViewName("mypage/myticket"); //원래 가야할 페이지로 이동
		}else { //session아이디를 불러오지 못했다면
			mav.setViewName("/memberGeneral/alert"); //알림페이지로 이동
			mav.addObject("msg", "로그인이 필요합니다");
			mav.addObject("url", "/loginForm"); //로그인 폼 url명령어 입력
			return mav;
		}//if end
		
		//페이징 시작
		int totalRowCount = myticketDao.total();
		// 페이징 파트
        int numPerPage = 12; // 한 페이지당 레코드(글) 갯수
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
		
		
        List<Map<String, Object>> list = null;
        if (totalRowCount > 0) {
    		list = myticketDao.list(startRow, endRow, s_m_id);
    		mav.addObject("list", list);
     	    mav.addObject("total", totalRowCount);
            mav.addObject("pageNum", currentPage);
            mav.addObject("count", totalRowCount);
            mav.addObject("totalPage", totalPage);
            mav.addObject("startPage", startPage);
            mav.addObject("endPage", endPage);
        } else {
            System.out.println("페이지 불러오기 실패");
        } // if end
		
		return mav;
	}//list() end
	
	
	@RequestMapping("mypage/myticket/{tck_num}")
	public ModelAndView detail(@PathVariable String tck_num) {
		ModelAndView mav=new ModelAndView();
		
		//콘서트와 조인한 행 한 줄 Map 담아오기
		Map<String, Object> detail = new HashMap<>();
		detail = myticketDao.detail(tck_num);
		
		//좌석번호와 좌석당 가격 List 담아오기
		List<TicketDetailDTO> list = new ArrayList<>();
		list = myticketDao.details(tck_num);
		
		mav.setViewName("mypage/myticketDetail");
		mav.addObject("detail", detail);
		mav.addObject("list", list);
		
		return mav;
	}//detail() end
	
	
	@RequestMapping("mypage/myticket/cancelPolicy/{tck_num}")
	public ModelAndView cancelPolicy(@PathVariable String tck_num) {
		ModelAndView mav=new ModelAndView();
		
		mav.setViewName("mypage/myticketCancelPolicy");
		mav.addObject("tck_num", tck_num);
		return mav;
	}//cancelPolicy() end
	
	
	
	
	
	
	@RequestMapping("mypage/myticket/delete/{tck_num}")
	public ModelAndView delete(@PathVariable String tck_num) {
		ModelAndView mav=new ModelAndView();
		

		int cntDetail = myticketDao.deleteDetail(tck_num);
		int cntOrder = myticketDao.deleteOrder(tck_num);
		
		/*
		if(cntDetail >= 1 ) {
			System.out.println("티켓주문상세서 삭제 완료");
		}else {
			System.out.println("티켓주문상세서 삭제 실패");
		}
		
		if(cntOrder == 1 ) {
			System.out.println("티켓주문서 삭제 완료");
		}else {
			System.out.println("티켓주문서 삭제 실패");
		}
		*/
		
		mav.setViewName("/memberGeneral/alert"); //알림페이지로 이동
		mav.addObject("msg", "결제를 취소하였습니다.");
		mav.addObject("url", "/mypage/mypageG");
		return mav;
	}//delete() end
	
}//class end
