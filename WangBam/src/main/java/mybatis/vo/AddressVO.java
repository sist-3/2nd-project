package mybatis.vo;

public class AddressVO {
	private String ad_idx,
	us_idx,
	ad_name,
	ad_postal_code,
	ad_addr,
	ad_addr_detail,
	ad_tel,
	ad_default;
	private UserVO uvo;
	
	public String getAd_idx() {
		return ad_idx;
	}
	public void setAd_idx(String ad_idx) {
		this.ad_idx = ad_idx;
	}
	public String getUs_idx() {
		return us_idx;
	}
	public void setUs_idx(String us_idx) {
		this.us_idx = us_idx;
	}
	public String getAd_name() {
		return ad_name;
	}
	public void setAd_name(String ad_name) {
		this.ad_name = ad_name;
	}
	public String getAd_postal_code() {
		return ad_postal_code;
	}
	public void setAd_postal_code(String ad_postal_code) {
		this.ad_postal_code = ad_postal_code;
	}
	public String getAd_addr() {
		return ad_addr;
	}
	public void setAd_addr(String ad_addr) {
		this.ad_addr = ad_addr;
	}
	public String getAd_addr_detail() {
		return ad_addr_detail;
	}
	public void setAd_addr_detail(String ad_addr_detail) {
		this.ad_addr_detail = ad_addr_detail;
	}
	public String getAd_tel() {
		return ad_tel;
	}
	public void setAd_tel(String ad_tel) {
		this.ad_tel = ad_tel;
	}
	public String getAd_default() {
		return ad_default;
	}
	public void setAd_default(String ad_default) {
		this.ad_default = ad_default;
	}
	public UserVO getUvo() {
		return uvo;
	}
	public void setUvo(UserVO uvo) {
		this.uvo = uvo;
	}
}
