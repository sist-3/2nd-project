package mybatis.vo;

import java.util.List;

public class BoardVO {
	private String bo_Idx,
	us_idx,
	pd_idx,
	bo_type,
	bo_title,
	bo_content,
	bo_write_date,
	bo_hit,
	bo_img,
	bo_score,
	bo_status,
	answer_status;
	private UserVO uvo;
	private ProductVO pvo;
	private List<CommentVO> c_list;
	
	public List<CommentVO> getC_list() {
		return c_list;
	}
	public void setC_list(List<CommentVO> c_list) {
		this.c_list = c_list;
	}
	public String getAnswer_status() {
		return answer_status;
	}
	public void setAnswer_status(String answer_status) {
		this.answer_status = answer_status;
	}
	
	public String getBo_Idx() {
		return bo_Idx;
	}
	public void setBo_Idx(String bo_Idx) {
		this.bo_Idx = bo_Idx;
	}
	public String getUs_idx() {
		return us_idx;
	}
	public void setUs_idx(String us_idx) {
		this.us_idx = us_idx;
	}
	public String getPd_idx() {
		return pd_idx;
	}
	public void setPd_idx(String pd_idx) {
		this.pd_idx = pd_idx;
	}
	public String getBo_type() {
		return bo_type;
	}
	public void setBo_type(String bo_type) {
		this.bo_type = bo_type;
	}
	public String getBo_title() {
		return bo_title;
	}
	public void setBo_title(String bo_title) {
		this.bo_title = bo_title;
	}
	public String getBo_content() {
		return bo_content;
	}
	public void setBo_content(String bo_content) {
		this.bo_content = bo_content;
	}
	public String getBo_write_date() {
		return bo_write_date;
	}
	public void setBo_write_date(String bo_write_date) {
		this.bo_write_date = bo_write_date;
	}
	public String getBo_hit() {
		return bo_hit;
	}
	public void setBo_hit(String bo_hit) {
		this.bo_hit = bo_hit;
	}
	public String getBo_img() {
		return bo_img;
	}
	public void setBo_img(String bo_img) {
		this.bo_img = bo_img;
	}
	public String getBo_score() {
		return bo_score;
	}
	public void setBo_score(String bo_score) {
		this.bo_score = bo_score;
	}
	public String getBo_status() {
		return bo_status;
	}
	public void setBo_status(String bo_status) {
		this.bo_status = bo_status;
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
