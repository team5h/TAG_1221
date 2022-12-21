package kr.co.itwill.concertHall;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ConcertHallCont {

	public ConcertHallCont() {
		System.out.println("--------ConcertHallCont() 객체 생성");
	}// default constructor
	
	
	@RequestMapping("/concertHall/yes24live")
	public String yes24live() {
		return "/concertHall/yes24live";
	}//yes24live() end
	
	@RequestMapping("/concertHall/bluesquare")
	public String bluesquare() {
		return "/concertHall/bluesquare";
	}//bluesquare() end
	
}//class end
