package mybatis.vo;

public class CategoryVO {
	private String ct_idx, ct_name, odCnt_per_pdCnt;

	public String getOdCnt_per_pdCnt() {
		return odCnt_per_pdCnt;
	}

	public void setOdCnt_per_pdCnt(String odCnt_per_pdCnt) {
		this.odCnt_per_pdCnt = odCnt_per_pdCnt;
	}

	public String getCt_idx() {
		return ct_idx;
	}

	public void setCt_idx(String ct_idx) {
		this.ct_idx = ct_idx;
	}

	public String getCt_name() {
		return ct_name;
	}

	public void setCt_name(String ct_name) {
		this.ct_name = ct_name;
	}
}
