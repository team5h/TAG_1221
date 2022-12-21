package kr.co.itwill.myproduct;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.itwill.myproduct.MyproductDTO;
import kr.co.itwill.product.ProductDAO;

@Controller
public class MyproductCont {

	public MyproductCont() {
		System.out.println("-----MyproductCont() 객체생성됨");
	}//end
	
	@Autowired
	MyproductDAO myproductDao;
	
	/*
	@RequestMapping("mypage/myproduct")
	public String myproduct() {
		return "mypage/myproduct";
	}//myproduct() end
	*/
	
	@RequestMapping("mypage/myproduct")
	public ModelAndView list(HttpSession session, HttpServletRequest req) {
		String s_m_id=(String)session.getAttribute("s_m_id");
		
		ModelAndView mav=new ModelAndView();
		mav.setViewName("mypage/myproduct");
		
		//페이징 시작
		int totalRowCount = myproductDao.orderCount(s_m_id);
		mav.addObject("orderCount", totalRowCount);
		// 페이징 파트
        int numPerPage = 12; // 한 페이지당 레코드(글) 개수
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
    		list = myproductDao.list(s_m_id, startRow, endRow);
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
		
		/*
		List<MyproductDTO> list=myproductDao.list(s_m_id);
		//myproductDao.orderCount(s_m_id);
		//System.out.println(myproductDao.orderCount(s_m_id));
		mav.addObject("list", list);
		mav.addObject("orderCount", myproductDao.orderCount(s_m_id));
		*/
		
		return mav;
		
	}//list() end
	
	@RequestMapping("mypage/pDetail/{order_num}")
	public ModelAndView detail(@PathVariable String order_num, HttpServletRequest req) {
		ModelAndView mav=new ModelAndView();
		mav.setViewName("mypage/pDetail");
		
		//페이징 시작
		int totalRowCount = myproductDao.total(order_num);
		mav.addObject("ptCount", totalRowCount);
		// 페이징 파트
        int numPerPage = 12; // 한 페이지당 레코드(글) 개수
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
		
		
        List<Map<String, Object>> detail = null;
        if (totalRowCount > 0) {
        	detail = myproductDao.detail(order_num, startRow, endRow);
        	    		
        	mav.addObject("detail", detail);
     	    mav.addObject("total", totalRowCount);
            mav.addObject("pageNum", currentPage);
            mav.addObject("count", totalRowCount);
            mav.addObject("totalPage", totalPage);
            mav.addObject("startPage", startPage);
            mav.addObject("endPage", endPage);
        } else {
            System.out.println("페이지 불러오기 실패");
        } // if end
        
		//mav.addObject("detail", myproductDao.detail(order_num));
		
		return mav;
		
	}//detail() end
	
	
	
}//class end
