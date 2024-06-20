package util;

public class Paging {
	int nowPage = 1; // 현재페이지
	int numPerPage = 10; // 한 페이지 당 표현할 게시물 수
	int totalRecord; // 총 게시물 수
	int pagePerBlock = 5; // 한 블럭 당 보여질 페이지 묶음
	int totalPage; // 총 페이지 수
	int begin; // 현재 페이지 값에 따라 bbs_t테이블에서 가져올 게시물의 시작 행 번호
	int end; // 현재 페이지 값에 따라 bbs_t테이블에서 가져올 게시물의 마지막 행 번호
	int startPage; // 한 블럭의 시작 페이지
	int endPage; // 한 블럭의 마지막 페이지

	public Paging() {}

	public Paging(int numPerPage, int pagePerblock) {
		this.numPerPage = numPerPage;
		this.pagePerBlock = pagePerblock;
	}

	public int getNowPage() {
		return nowPage;
	}

	public void setNowPage(int nowPage) {
		if (nowPage > totalPage)
			this.nowPage = totalPage;

		this.nowPage = nowPage;

		begin = (nowPage - 1) * numPerPage + 1;
		end = nowPage * numPerPage;

		startPage = (int) ((nowPage - 1) / pagePerBlock) * pagePerBlock + 1;
		endPage = startPage + pagePerBlock - 1;

		if (endPage > totalPage)
			endPage = totalPage;
	}

	public int getNumPerPage() {
		return numPerPage;
	}

	public void setNumPerPage(int numPerPage) {
		this.numPerPage = numPerPage;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		this.totalPage = (int) (Math.ceil((double) totalRecord / numPerPage));
	}

	public int getPagePerBlock() {
		return pagePerBlock;
	}

	public void setPagePerBlock(int pagePerBlock) {
		this.pagePerBlock = pagePerBlock;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getBegin() {
		return begin;
	}

	public void setBegin(int begin) {
		this.begin = begin;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
}
