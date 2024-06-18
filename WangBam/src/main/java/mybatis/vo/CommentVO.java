package mybatis.vo;

public class CommentVO {
	private String co_idx,
	us_idx,
	bo_idx,
	co_content,
	co_write_date,
	co_status;
	private UserVO uvo;
	private BoardVO bvo;
	
	public String getCo_idx() {
		return co_idx;
	}
	public void setCo_idx(String co_idx) {
		this.co_idx = co_idx;
	}
	public String getUs_idx() {
		return us_idx;
	}
	public void setUs_idx(String us_idx) {
		this.us_idx = us_idx;
	}
	public String getbo_idx() {
		return bo_idx;
	}
	public void setbo_idx(String bo_idx) {
		this.bo_idx = bo_idx;
	}
	public String getCo_content() {
		return co_content;
	}
	public void setCo_content(String co_content) {
		this.co_content = co_content;
	}
	public String getCo_write_date() {
		return co_write_date;
	}
	public void setCo_write_date(String co_write_date) {
		this.co_write_date = co_write_date;
	}
	public String getCo_status() {
		return co_status;
	}
	public void setCo_status(String co_status) {
		this.co_status = co_status;
	}
	public UserVO getUvo() {
		return uvo;
	}
	public void setUvo(UserVO uvo) {
		this.uvo = uvo;
	}
	public BoardVO getBvo() {
		return bvo;
	}
	public void setBvo(BoardVO bvo) {
		this.bvo = bvo;
	}
}
