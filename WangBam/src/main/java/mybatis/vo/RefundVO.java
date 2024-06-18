package mybatis.vo;

public class RefundVO {
	private String re_idx,
	or_idx,
	re_code,
	re_content,
	re_status;
	private OrderVO ovo;
	
	public String getRe_idx() {
		return re_idx;
	}
	public void setRe_idx(String re_idx) {
		this.re_idx = re_idx;
	}
	public String getOr_idx() {
		return or_idx;
	}
	public void setOr_idx(String or_idx) {
		this.or_idx = or_idx;
	}
	public String getRe_code() {
		return re_code;
	}
	public void setRe_code(String re_code) {
		this.re_code = re_code;
	}
	public String getRe_content() {
		return re_content;
	}
	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}
	public String getRe_status() {
		return re_status;
	}
	public void setRe_status(String re_status) {
		this.re_status = re_status;
	}
	public OrderVO getOvo() {
		return ovo;
	}
	public void setOvo(OrderVO ovo) {
		this.ovo = ovo;
	}
}
