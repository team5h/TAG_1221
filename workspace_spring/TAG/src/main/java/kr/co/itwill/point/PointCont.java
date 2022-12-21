package kr.co.itwill.point;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.itwill.notice.NoticeDTO;

@Controller
public class PointCont {

	public PointCont() {
		System.out.println("-----PointCont() 객체생성됨");
	}//end
	
	@Autowired
	PointDAO pointDao;
	
	@RequestMapping("pointDetail/detail")
	public ModelAndView list(HttpSession session, HttpServletRequest req) {
		String s_m_id=(String)session.getAttribute("s_m_id");
		
		ModelAndView mav=new ModelAndView();
		mav.setViewName("pointDetail/detail");
		
		//페이징 시작
		int totalRowCount = pointDao.ptCount(s_m_id);
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
		
		
        List<Map<String, Object>> list = null;
        if (totalRowCount > 0) {
    		list = pointDao.list(s_m_id, startRow, endRow);
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
		int ptCount=pointDao.ptCount(s_m_id);
		mav.addObject("ptCount", ptCount);
		
		List<PointDTO> list=pointDao.list(s_m_id);
		mav.addObject("list", list);
		*/
		
		return mav;
		
	}//list() end
	
}//class end
