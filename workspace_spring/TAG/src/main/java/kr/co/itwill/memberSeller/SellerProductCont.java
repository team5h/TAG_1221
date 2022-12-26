package kr.co.itwill.memberSeller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpSession;

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

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;

import kr.co.itwill.productOrder.ProdcutOrderDTO;
import net.utility.UploadSaveManager;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Controller
public class SellerProductCont {
	
	public SellerProductCont() {
		System.out.println("----------------ProdcutCont()");
	}//end
	
	@Autowired
	SellerProductDAO sellerproductdao;
	
	@RequestMapping("/mypageS/create")
	public ModelAndView productForm(HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		String p_id=(String)session.getAttribute("s_p_id");	

		if(p_id!=null) { //session아이디를 불러왔다면
			mav.setViewName("/memberSeller/productForm");
			mav.addObject("concertlist",sellerproductdao.concertlist());
			
			return mav;
			
		}else { //session아이디를 불러오지 못했다면
			mav.setViewName("/memberGeneral/alert"); //알림페이지로 이동
			mav.addObject("msg", "로그인이 필요합니다");
			mav.addObject("url", "/loginForm"); //로그인 폼 url명령어 입력
			
			return mav;
		}//if end
	
	}//end

//------------------------------------------------------------------------- SUMMER NOTE 
	
	@RequestMapping(value="/uploadSummernoteImageFile", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request )  {
		JsonObject jsonObject = new JsonObject();
		
		// 내부경로로 저장
		String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
		String fileRoot = contextRoot+"/summernoteImg/";
		
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		
		File targetFile = new File(fileRoot + savedFileName);	
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
			jsonObject.addProperty("url", "/summernoteImg/"+savedFileName); // contextroot + resources + 저장할 내부 폴더명
			jsonObject.addProperty("responseCode", "success");
				
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String a = jsonObject.toString();
		return a;
	}

//------------------------------------------------------------------------- SUMMER NOTE 	
	
	@RequestMapping(value = "/mypageS/productProc", method = RequestMethod.POST )
	public ModelAndView productProc(@ModelAttribute SellerProductDTO dto
									,HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		
		
		//----------------------------------------------------- 첨부 파일 저장
		
		String basePath = req.getRealPath("/storage"); 	
		
		// 전달받은 이미지 실제파일 저장 
		MultipartFile fileimg = dto.getFileimg();

		String postername = UploadSaveManager.saveFileSpring30(fileimg, basePath);
		dto.setPostername(postername);
		
		int cnt = sellerproductdao.productInsert(dto); 

		if (cnt == 0) {
			mav.setViewName("index");	
			// 메세지페이지? 
		} else {
			mav.setViewName("redirect:/mypageS/productM");
			//mav.setViewName("/mypageS/productM");
		}
		
		return mav; 
	}//productProc() end
	
	
	@RequestMapping("/mypageS/productM")
	public ModelAndView productM(HttpSession session, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		
		String p_id = (String) session.getAttribute("s_p_id");

		if(p_id!=null) { //session아이디를 불러왔다면
			mav.setViewName("/memberSeller/productM");
			
			int totalRowCount = sellerproductdao.totpro_cnt(p_id); // 총 개수
			
			//페이징설정 
			int numPerPage = 7;
			int pagePerBlock = 10;
			
			String pageNum = req.getParameter("pageNum");	// 현재 페이지값 받아오기
			if (pageNum == null) {
				pageNum = "1";
			}//if end
			
			int currentPage = Integer.parseInt(pageNum);			// 현재 페이지
			int startRow 	= (currentPage-1) * numPerPage + 1;		// 한 페이지 글 목록에서 시작하는 행
			int endRow		= currentPage * numPerPage; 			// 한 페이지 글 목록에서 끝나는 행
			
			// 페이지 수 
			double totcnt = (double)totalRowCount/numPerPage;		// 전체 페이지 수 (전체글개수 / 5개)
			int totalPage = (int)Math.ceil(totcnt);					// Math.ceil : 소수점 올림
			
			double d_page = (double)currentPage/pagePerBlock;		// 현재 페이지 넘버 / 전체 페이지 수
			int Pages = (int)Math.ceil(d_page) -1;					// 페이지 목록을 하나로 묶음? (1-10 목록은 1, 11-20 목록은 2)
			int startPage = Pages*pagePerBlock +1;					// 페이지 목록(ex 1~10번페이지 / 11~20번 페이지)에서 시작하는 페이지 넘버 (10개씩이면 1,11,21···.)
			int endPage = startPage + pagePerBlock -1;			    // 페이지 목록에서 마지막 페이지 넘버 (10개씩이면 10,20,30···.)
			
			List list = null;
	        if (totalRowCount > 0) {
	        	list = sellerproductdao.productlist(startRow, endRow, p_id);
	        } else {
	            list = Collections.emptyList(); // 안 넣어도 상관 없음
	        } // if end
	        
	        mav.addObject("total", totalRowCount);
	        mav.addObject("productlist",list);
	        mav.addObject("pageNum", currentPage);
	
	        mav.addObject("count", totalRowCount);
	        mav.addObject("totalPage", totalPage);
	        mav.addObject("startPage", startPage);
	        mav.addObject("endPage", endPage);
	        
			return mav; 
			
		}else { //session아이디를 불러오지 못했다면
			mav.setViewName("/memberGeneral/alert"); //알림페이지로 이동
			mav.addObject("msg", "로그인이 필요합니다");
			mav.addObject("url", "/loginForm"); //로그인 폼 url명령어 입력
			
			return mav;
		}//if end
		
	}// end

	
	@RequestMapping("/productdetail/{pro_no}")
	public ModelAndView productdetail(@PathVariable int pro_no, HttpSession session){
		ModelAndView mav = new ModelAndView();
		
		String p_id = (String) session.getAttribute("s_p_id");

		if(p_id!=null) { //session아이디를 불러왔다면
			
			mav.setViewName("/memberSeller/productMdetail");
			mav.addObject("productdetail", sellerproductdao.productdetail(pro_no, p_id));
			
			return mav;
			
		}else { //session아이디를 불러오지 못했다면
			mav.setViewName("/memberGeneral/alert"); //알림페이지로 이동
			mav.addObject("msg", "로그인이 필요합니다");
			mav.addObject("url", "/loginForm"); //로그인 폼 url명령어 입력
			
			return mav;
		}//if end
		
	}//end
	
	@ResponseBody
	@RequestMapping(value = "/mypageS/delete", method = RequestMethod.POST )
	 public int ckdelete(@RequestParam Map<String, Object> parameters) throws Exception{
	      
		  /* chkList로 넘어온 데이터를 문자열로 변환 */
	      String chkArray = parameters.get("chkList").toString();
	      
	      // 배열 [] 기호 삭제
	      chkArray = chkArray.substring(1, (chkArray.length()- 1));
	      // " 기호 삭제
	      chkArray = chkArray.replace("\"","");
	      // ,단위로 문자열 분해 후 배열에 담기
	      String [] chkList = chkArray.split(","); 
	      // 배열을 List로 변환
	      List list = Arrays.asList(chkList);
		
	      SellerProductDTO dto = new SellerProductDTO();
	      dto.setChkList(list);
	      
	      return sellerproductdao.chkdelete(dto);
	}//end
	
	
	@ResponseBody
	@RequestMapping(value = "/mypageS/statusupdate", method = RequestMethod.POST)
	public int productstusupdate (@RequestParam int pro_no, @RequestParam String status) {
		SellerProductDTO dto = new SellerProductDTO();
		dto.setPro_no(pro_no);
		dto.setStatus(status);
		
		return sellerproductdao.productstatusup(dto);
	}//end
	

	@RequestMapping (value = "/mypageS/productupdate", method = RequestMethod.POST )
	public ModelAndView productupdate(@ModelAttribute SellerProductDTO dto, HttpServletRequest req) {
		
		String basePath = req.getRealPath("/storage");
		SellerProductDTO oldDTO = sellerproductdao.productread(dto.getPro_no());	
		
		//----------------------------------------------------- 파일을 수정할것인가?
		
		// ①. 
		MultipartFile fileimg = dto.getFileimg();
		if (fileimg.getSize() > 0) {
		// = 포스터의 파일 크기가 0이상이면 = 새로운 파일이 첨부되었다면 
			
			UploadSaveManager.deleteFile(basePath, oldDTO.getPostername());	// 기존 파일 삭제
			String postername = UploadSaveManager.saveFileSpring30(fileimg, basePath);	// 새로 첨부된 파일 저장
			dto.setPostername(postername);	//새로 첨부된 파일명 dto에 저장
		
		}else {
		// 포스터를 수정하지 않았다면 = 새로운 파일이 첨부되지 않았다면 
			
			dto.setPostername(oldDTO.getPostername()); 		// 기존 파일명 그대로 저장
		
		}//if end
		
		//----------------------------------------------------- 파일을 수정할것인가?
		
		ModelAndView mav = new ModelAndView();
		
		int cnt = sellerproductdao.productupdate(dto);
		
		if (cnt == 0) {
			mav.setViewName("/memberSeller/ErrorView");
		}else {
			mav.setViewName("redirect:/mypageS/productM");
		}//if end

		return mav;
	}//end

	@ResponseBody
	@RequestMapping(value = "/mypageS/productdelete", method = RequestMethod.POST)
	public int productdelete(@RequestParam int pro_no, HttpServletRequest req) {
				
		String postername = sellerproductdao.posternameread(pro_no);	// storage에서 파일 삭제
		if(postername != null && !postername.equals("-")) {
			ServletContext application = req.getSession().getServletContext();
			String path = application.getRealPath("/storage");	// 실제 물리적 경로
			
			File file = new File(path + "\\" + postername);
			if(file.exists()) {
				file.delete();
			}//if end
		}//if end
		
		int cnt = sellerproductdao.productdelete(pro_no); // DB에서 행 삭제
		
		return cnt;	
	}//end 

	@RequestMapping ("/mypageS/orderM") 
	public ModelAndView orderM(HttpSession session, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		
		String p_id = (String) session.getAttribute("s_p_id");
		
		if(p_id!=null) { //session아이디를 불러왔다면
		
			mav.setViewName("/memberSeller/orderM");
			
			//페이징
			int totalRowCount = sellerproductdao.totord_cnt(p_id); // 총 개수
			
			//페이징설정 
			int numPerPage = 10;
			int pagePerBlock = 10;
			
			String pageNum = req.getParameter("pageNum");	// 현재 페이지값 받아오기
			if (pageNum == null) {
				pageNum = "1";
			}//if end
			
			int currentPage = Integer.parseInt(pageNum);			// 현재 페이지
			int startRow 	= (currentPage-1) * numPerPage + 1;		// 한 페이지 글 목록에서 시작하는 행
			int endRow		= currentPage * numPerPage; 			// 한 페이지 글 목록에서 끝나는 행
			
			// 페이지 수 
			double totcnt = (double)totalRowCount/numPerPage;		// 전체 페이지 수 (전체글개수 / 5개)
			int totalPage = (int)Math.ceil(totcnt);					// Math.ceil : 소수점 올림
			
			double d_page = (double)currentPage/pagePerBlock;		// 현재 페이지 넘버 / 전체 페이지 수
			int Pages = (int)Math.ceil(d_page) -1;					// 페이지 목록을 하나로 묶음? (1-10 목록은 1, 11-20 목록은 2)
			int startPage = Pages*pagePerBlock +1;					// 페이지 목록(ex 1~10번페이지 / 11~20번 페이지)에서 시작하는 페이지 넘버 (10개씩이면 1,11,21···.)
			int endPage = startPage + pagePerBlock -1;			    // 페이지 목록에서 마지막 페이지 넘버 (10개씩이면 10,20,30···.)
			
			List list = null;
	        if (totalRowCount > 0) {
	        	list = sellerproductdao.orderlist(startRow, endRow, p_id);
	        } else {
	            list = Collections.emptyList(); // 안 넣어도 상관 없음
	        } // if end
	        
			//mav.addObject("productlist", sellerproductdao.productlist());
	        mav.addObject("total", totalRowCount);
	        mav.addObject("orderlist",list);
	        mav.addObject("pageNum", currentPage);
	
	        mav.addObject("count", totalRowCount);
	        mav.addObject("totalPage", totalPage);
	        mav.addObject("startPage", startPage);
	        mav.addObject("endPage", endPage);  
			
			return mav;
			
		}else { //session아이디를 불러오지 못했다면
			mav.setViewName("/memberGeneral/alert"); //알림페이지로 이동
			mav.addObject("msg", "로그인이 필요합니다");
			mav.addObject("url", "/loginForm"); //로그인 폼 url명령어 입력
			
			return mav;
		}//if end
		
	}//end
	
	@RequestMapping("/mypageS/orderMdetail/{order_num}")
	public ModelAndView orderMdetail(@PathVariable String order_num, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		String p_id = (String) session.getAttribute("s_p_id");

		if(p_id!=null) { //session아이디를 불러왔다면
			mav.setViewName("/memberSeller/orderMdetail");
		
			mav.addObject("orderdetailList",sellerproductdao.orderdetailList(order_num,p_id));
			mav.addObject("orderdetail",sellerproductdao.orderdetail(order_num,p_id));
			return mav;
			
		}else { //session아이디를 불러오지 못했다면
			mav.setViewName("/memberGeneral/alert"); //알림페이지로 이동
			mav.addObject("msg", "로그인이 필요합니다");
			mav.addObject("url", "/loginForm"); //로그인 폼 url명령어 입력
			
			return mav;
		}//if end
		
	}//end
	
	@RequestMapping(value = "/mypageS/orderstus/{order_num}", method = RequestMethod.POST)
	public String orderstus(@RequestParam Map<String, Object> map) {

		sellerproductdao.orderstusupdate(map);
			
		return "redirect:/mypageS/orderMdetail/{order_num}";
	}//end
	
	@RequestMapping(value = "/mypageS/orderdetailProc/{order_num}", method = RequestMethod.POST)
	public String orderdetailProc (@ModelAttribute ProdcutOrderDTO dto) {

		sellerproductdao.orderdetailupdate(dto);
		
		return "redirect:/mypageS/orderMdetail/{order_num}";
	}
	
	@RequestMapping(value = "/mypageS/productsearch", method = RequestMethod.POST)
	public ModelAndView S_proSearch(HttpServletRequest req, HttpSession session
								   ,@RequestParam(defaultValue = "") String pro_name) {
		ModelAndView mav = new ModelAndView();
		
		String p_id = (String) session.getAttribute("s_p_id");

		if(p_id!=null) { //session아이디를 불러왔다면

			mav.setViewName("/memberSeller/productM");
			
	
			//페이징
			int totalRowCount = sellerproductdao.totpro_cnt(p_id); // 총 개수
			int numPerPage = 7;
			int pagePerBlock = 10;
			
			String pageNum = req.getParameter("pageNum");	// 현재 페이지값 받아오기
			if (pageNum == null) {
				pageNum = "1";
			}//if end
			
			int currentPage = Integer.parseInt(pageNum);			// 현재 페이지
			int startRow 	= (currentPage-1) * numPerPage + 1;		// 한 페이지 글 목록에서 시작하는 행
			int endRow		= currentPage * numPerPage; 			// 한 페이지 글 목록에서 끝나는 행
			
			// 페이지 수 
			double totcnt = (double)totalRowCount/numPerPage;		// 전체 페이지 수 (전체글개수 / 5개)
			int totalPage = (int)Math.ceil(totcnt);					// Math.ceil : 소수점 올림
			
			double d_page = (double)currentPage/pagePerBlock;		// 현재 페이지 넘버 / 전체 페이지 수
			int Pages = (int)Math.ceil(d_page) -1;					// 페이지 목록을 하나로 묶음? (1-10 목록은 1, 11-20 목록은 2)
			int startPage = Pages*pagePerBlock +1;					// 페이지 목록(ex 1~10번페이지 / 11~20번 페이지)에서 시작하는 페이지 넘버 (10개씩이면 1,11,21···.)
			int endPage = startPage + pagePerBlock -1;			    // 페이지 목록에서 마지막 페이지 넘버 (10개씩이면 10,20,30···.)
			
			List list = null;
	        if (totalRowCount > 0) {
	        	list = sellerproductdao.S_proSearch(startRow, endRow, p_id, pro_name);
	        } else {
	            list = Collections.emptyList(); // 안 넣어도 상관 없음
	        } // if end
	        
	        mav.addObject("total", totalRowCount);
	        mav.addObject("productlist",list);
	        mav.addObject("pageNum", currentPage);
	
	        mav.addObject("count", totalRowCount);
	        mav.addObject("totalPage", totalPage);
	        mav.addObject("startPage", startPage);
	        mav.addObject("endPage", endPage);
	        
	        mav.addObject("page", "page");
			
			return mav;
			
		}else { //session아이디를 불러오지 못했다면
			mav.setViewName("/memberGeneral/alert"); //알림페이지로 이동
			mav.addObject("msg", "로그인이 필요합니다");
			mav.addObject("url", "/loginForm"); //로그인 폼 url명령어 입력
			
			return mav;
		}//if end
	}//end
	
	@RequestMapping(value = "/mypageS/ordersearch" )
	public ModelAndView S_ordSearch (HttpServletRequest req, HttpSession session
									,@RequestParam(defaultValue = "") String order_num) {
		
		ModelAndView mav = new ModelAndView();
		
		String p_id = (String) session.getAttribute("s_p_id");

		if(p_id!=null) { //session아이디를 불러왔다면

			mav.setViewName("/memberSeller/orderM");
			
			//페이징
			int totalRowCount = sellerproductdao.totord_cnt(p_id); // 총 개수
			
			//페이징설정 
			int numPerPage = 10;
			int pagePerBlock = 10;
			
			String pageNum = req.getParameter("pageNum");	// 현재 페이지값 받아오기
			if (pageNum == null) {
				pageNum = "1";
			}//if end
			
			int currentPage = Integer.parseInt(pageNum);			// 현재 페이지
			int startRow 	= (currentPage-1) * numPerPage + 1;		// 한 페이지 글 목록에서 시작하는 행
			int endRow		= currentPage * numPerPage; 			// 한 페이지 글 목록에서 끝나는 행
			
			// 페이지 수 
			double totcnt = (double)totalRowCount/numPerPage;		// 전체 페이지 수 (전체글개수 / 5개)
			int totalPage = (int)Math.ceil(totcnt);					// Math.ceil : 소수점 올림
			
			double d_page = (double)currentPage/pagePerBlock;		// 현재 페이지 넘버 / 전체 페이지 수
			int Pages = (int)Math.ceil(d_page) -1;					// 페이지 목록을 하나로 묶음? (1-10 목록은 1, 11-20 목록은 2)
			int startPage = Pages*pagePerBlock +1;					// 페이지 목록(ex 1~10번페이지 / 11~20번 페이지)에서 시작하는 페이지 넘버 (10개씩이면 1,11,21···.)
			int endPage = startPage + pagePerBlock -1;			    // 페이지 목록에서 마지막 페이지 넘버 (10개씩이면 10,20,30···.)
			
			List list = null;
	        if (totalRowCount > 0) {
	        	list = sellerproductdao.S_ordSearch(startRow, endRow, p_id, order_num);
	        } else {
	            list = Collections.emptyList(); // 안 넣어도 상관 없음
	        } // if end
	        
	        mav.addObject("total", totalRowCount);
	        mav.addObject("orderlist",list);
	        mav.addObject("pageNum", currentPage);
	
	        mav.addObject("count", totalRowCount);
	        mav.addObject("totalPage", totalPage);
	        mav.addObject("startPage", startPage);
	        mav.addObject("endPage", endPage);
	        
			return mav;
		
		}else { //session아이디를 불러오지 못했다면
			mav.setViewName("/memberGeneral/alert"); //알림페이지로 이동
			mav.addObject("msg", "로그인이 필요합니다");
			mav.addObject("url", "/loginForm"); //로그인 폼 url명령어 입력
			
			return mav;
		
		}//if end
		
	}//end
	
	
}//Cont end
