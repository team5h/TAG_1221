package kr.co.itwill.notice;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Controller
/*@RequestMapping("/")*/
public class NoticeCont {

	public NoticeCont() {
		System.out.println("-----NoticeCont() 객체생성됨");
	}//end
	
	@Autowired
	NoticeDAO noticeDao;
	
	
	@RequestMapping(value="write")
	public String write() {
		return "/notice/write";
	}//write() end
	
	/*
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public void insert(@ModelAttribute NoticeDTO dto) {
		String subject=dto.getSubject();
		System.out.println(subject);//null		
	}*/
	
	/*
	@RequestMapping("/notice.do")
	public ModelAndView list() {
		ModelAndView mav=new ModelAndView();
		//redirect : 등록한 명령어를 호출할 수 있다		
		mav.setViewName("notice/list");
		return mav;
	}//home() end
	*/
	
	
	@RequestMapping(value = "notice/insert", method = RequestMethod.POST)
	public String insert(@RequestParam String subject, @RequestParam String edit) throws Exception {

		NoticeDTO notice=new NoticeDTO();
		notice.setSubject(subject);
		notice.setEdit(edit);
		
		noticeDao.insert(notice);
		
		return "redirect:/notice/list";
		
	}//insert() end
		
	
	@RequestMapping("notice/list")
	public ModelAndView list(HttpServletRequest req) {
		ModelAndView mav=new ModelAndView();
		mav.setViewName("notice/list");
		
		//페이징 시작
		int totalRowCount = noticeDao.total();
		// 페이징 파트
        int numPerPage = 5; // 한 페이지당 레코드(글) 개수
        int pagePerBlock = 3; // 페이지 리스트 (블럭당 페이지 수)

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
		
		
        List<NoticeDTO> list = null;
        if (totalRowCount > 0) {
    		list = noticeDao.list(startRow, endRow);
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
		List<NoticeDTO> list=noticeDao.list();
		//System.out.println(list.size());		
		mav.addObject("list", list);
		mav.addObject("cnt", list.size());
		*/
        
		return mav;
		
	}//list() end
	
	/*	
	@RequestMapping("/list")
	private List<NoticeDTO> list(@RequestParam String subject, @RequestParam String edit) throws Exception {
		return noticeDao.list(subject);
	}//list() end
	*/
	
	@ResponseBody
	@RequestMapping("notice/detail/{n_no}")
	public ModelAndView detail(@PathVariable int n_no) {
		ModelAndView mav=new ModelAndView();
		mav.setViewName("notice/detail");
		mav.addObject("notice", noticeDao.detail(n_no));
		
		return mav;
		
	}//detail() end
	
	
	@RequestMapping("notice/update")
	public ModelAndView update(@RequestParam int n_no) throws Exception {

		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("/notice/update");
		mav.addObject("notice", noticeDao.detail(n_no));
	
		return mav;
		
	}//update() end
	
	
	@RequestMapping("notice/updateProc")
	public String updateProc(@ModelAttribute NoticeDTO dto) throws Exception {
		//notice.setSubject();
		//notice.setEdit();
		
		noticeDao.update(dto);		
		
		return "redirect:/notice/detail/" + dto.getN_no();
		
	}//updateProc() end
	
	
	@RequestMapping("notice/delete")
	public String delete(int n_no) throws Exception {
		noticeDao.delete(n_no);
		
		return "redirect:/notice/list";
		
	}//delete() end
	 
}//class end
