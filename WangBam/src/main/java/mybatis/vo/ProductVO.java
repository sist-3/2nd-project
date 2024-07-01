package mybatis.vo;

public class ProductVO {
	private String pd_idx,
	ct_idx,
	pd_name,
	pd_price,
	pd_sale_price,
	pd_sale,
	pd_date,
	pd_cnt,
	pd_thumbnail_img,
	pd_detail_img,
	pd_last_update,
	pd_status;
	private CategoryVO cvo;
	
	public String getPd_idx() {
		return pd_idx;
	}
	public void setPd_idx(String pd_idx) {
		this.pd_idx = pd_idx;
	}
	public String getCt_idx() {
		return ct_idx;
	}
	public void setCt_idx(String ct_idx) {
		this.ct_idx = ct_idx;
	}
	public String getPd_name() {
		return pd_name;
	}
	public void setPd_name(String pd_name) {
		this.pd_name = pd_name;
	}
	public String getPd_price() {
		return pd_price;
	}
	public void setPd_price(String pd_price) {
		this.pd_price = pd_price;
	}
	public String getPd_sale_price() {
		return pd_sale_price;
	}
	public void setPd_sale_price(String pd_sale_price) {
		this.pd_sale_price = pd_sale_price;
	}
	public String getPd_sale() {
		return pd_sale;
	}
	public void setPd_sale(String pd_sale) {
		this.pd_sale = pd_sale;
	}
	public String getPd_date() {
		return pd_date;
	}
	public void setPd_date(String pd_date) {
		this.pd_date = pd_date;
	}
	public String getPd_cnt() {
		return pd_cnt;
	}
	public void setPd_cnt(String pd_cnt) {
		this.pd_cnt = pd_cnt;
	}
	public String getPd_thumbnail_img() {
		return pd_thumbnail_img;
	}
	public void setPd_thumbnail_img(String pd_thumbnail_img) {
		this.pd_thumbnail_img = pd_thumbnail_img;
	}
	public String getPd_detail_img() {
		return pd_detail_img;
	}
	public void setPd_detail_img(String pd_detail_img) {
		this.pd_detail_img = pd_detail_img;
	}
	public String getPd_last_update() {
		return pd_last_update;
	}
	public void setPd_last_update(String pd_last_update) {
		this.pd_last_update = pd_last_update;
	}
	public String getPd_status() {
		return pd_status;
	}
	public void setPd_status(String pd_status) {
		this.pd_status = pd_status;
	}
	public CategoryVO getCvo() {
		return cvo;
	}
	public void setCvo(CategoryVO cvo) {
		this.cvo = cvo;
	}
}
