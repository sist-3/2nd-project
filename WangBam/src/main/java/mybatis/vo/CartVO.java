package mybatis.vo;

public class CartVO {
	private String ca_idx,
	us_idx,
	pd_idx,
	ca_cnt;
	private UserVO uvo;
	private ProductVO pvo;
	
	public String getCa_idx() {
		return ca_idx;
	}
	public void setCa_idx(String ca_idx) {
		this.ca_idx = ca_idx;
	}
	public String getUs_idx() {
		return us_idx;
	}
	public void setUs_idx(String us_idx) {
		this.us_idx = us_idx;
	}
	public String getpd_idx() {
		return pd_idx;
	}
	public void setpd_idx(String pd_idx) {
		this.pd_idx = pd_idx;
	}
	public String getCa_cnt() {
		return ca_cnt;
	}
	public void setCa_cnt(String ca_cnt) {
		this.ca_cnt = ca_cnt;
	}
	public UserVO getUvo() {
		return uvo;
	}
	public void setUvo(UserVO uvo) {
		this.uvo = uvo;
	}
	public ProductVO getPvo() {
		return pvo;
	}
	public void setPvo(ProductVO pvo) {
		this.pvo = pvo;
	}
}
