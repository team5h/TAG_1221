package kr.co.itwill.orderDetail;

public class OrderDetailDTO {

	private String order_num;
	private int pro_no;
	private int detail_cnt;
	private int org_price;
	private String stus;

	public OrderDetailDTO() {}

	public String getOrder_num() {
		return order_num;
	}

	public void setOrder_num(String order_num) {
		this.order_num = order_num;
	}

	public int getPro_no() {
		return pro_no;
	}

	public void setPro_no(int pro_no) {
		this.pro_no = pro_no;
	}

	public int getDetail_cnt() {
		return detail_cnt;
	}

	public void setDetail_cnt(int detail_cnt) {
		this.detail_cnt = detail_cnt;
	}

	public int getOrg_price() {
		return org_price;
	}

	public void setOrg_price(int org_price) {
		this.org_price = org_price;
	}

	public String getStus() {
		return stus;
	}

	public void setStus(String stus) {
		this.stus = stus;
	}

	@Override
	public String toString() {
		return "OrderDetailDTO [order_num=" + order_num + ", pro_no=" + pro_no + ", detail_cnt=" + detail_cnt
				+ ", org_price=" + org_price + ", stus=" + stus + "]";
	}


	
}//DTO 
