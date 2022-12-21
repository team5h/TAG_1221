package kr.co.itwill.mypage;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.itwill.QnA.QnADTO;
import kr.co.itwill.coupon.CouponDAO;
import kr.co.itwill.myproduct.MyproductDAO;
import kr.co.itwill.myproduct.MyproductDTO;
import kr.co.itwill.product.ProductDAO;


@Controller
public class MypageGCont {
	
	public MypageGCont() {
		System.out.println("-----MypageGCont() 객체생성됨");
	}//end
	
	@Autowired
	MypageGDAO mypageGDao;
	

	@RequestMapping("mypage/mypageG")
	public ModelAndView mypage(HttpSession session) {
		ModelAndView mav=new ModelAndView();		
		
		//로그인 확인
		String s_m_id=(String)session.getAttribute("s_m_id");
		if(s_m_id!=null) { //session아이디를 불러왔다면
			mav.setViewName("mypage/mypageG"); //원래 가야할 페이지로 이동
		}else { //session아이디를 불러오지 못했다면
			mav.setViewName("/memberGeneral/alert"); //알림페이지로 이동
			mav.addObject("msg", "로그인이 필요합니다.");
			mav.addObject("url", "/loginForm"); //로그인 폼 url명령어 입력
			return mav;
		}//if end

		
		List<Map<String, Object>> list_p=mypageGDao.list_p(s_m_id);
		mav.addObject("list_p", list_p);
		
		mav.addObject("orderCount", mypageGDao.orderCount(s_m_id));
		
		int couponCnt=mypageGDao.couponCnt(s_m_id); 
		mav.addObject("couponCnt", couponCnt);
		
		List<Map<String, Object>> list_t=mypageGDao.list_t(s_m_id);
		mav.addObject("list_t", list_t);
		
		int tckCount=mypageGDao.tckCount(s_m_id);
		mav.addObject("tckCount", tckCount);
		
		int ptTotal=mypageGDao.ptTotal(s_m_id);
		mav.addObject("ptTotal", ptTotal);
		
		return mav;
		
	}//mypage() end
	
	
	@RequestMapping("/mypage/myqna")
	public ModelAndView myqna(HttpSession session) {
		String s_m_id=(String)session.getAttribute("s_m_id");
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/mypage/myqna");
		
		List<Map<String, Object>> myqna = mypageGDao.myqna(s_m_id);
		mav.addObject("myqna", myqna);
		
		List<Map<String, Object>> notAyet = mypageGDao.notAyet(s_m_id);
		mav.addObject("notAyet", notAyet);
		
		return mav;
		
	}//myqna() end
	
	
	
	
}//class end
