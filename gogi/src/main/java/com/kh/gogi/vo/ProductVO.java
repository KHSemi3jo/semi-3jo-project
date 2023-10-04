package com.kh.gogi.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

//VO(Value Object)
//-내 입맛대로 데이터를 모아서 저장하는 클래스(DB무관)
//-등록하지 않고 필요할 때마다 만들어서 사용
@Data
@NoArgsConstructor
public class ProductVO {
	private String type,keyword;//검색 분류 및 키워드
	private int page =1;//현재 페이지 번호(기본:1)
	private int size=20;//보여줄 게시판의 글 수(기본:10)
	private int count;//전체 글 수
	private int navigatorSize=10;//하단 네비게이터 표시 개수(기본:10)
	private String productType;
	
	
	public boolean isSearch() {
		return type != null&&keyword != null;
	}
	public int getBegin() {
		return (page-1)/navigatorSize*navigatorSize+1;
	}
	public int getEnd() {
		int end = getBegin() + navigatorSize - 1;
		return Math.min(getPageCount(), end);
	}
	public boolean isFirst() {
		return getBegin() == 1;
	}
	
	public String getPrevQueryString() {
		if(isSearch()) {//검색
			return "page="+(getBegin()-1)+"&type="+type+"&keyword="+keyword;
		}
		else {//목록
			return "page="+(getBegin()-1);
		}
	}
	
	public int getPageCount() {
		return (count-1)/size+1;
	}
	public boolean isLast() {
		return getEnd() >= getPageCount();//계산된끝번호 >= 페이지개수
	}
	public String getNextQueryString() {
		if(isSearch()) {//검색
			return "page="+(getEnd()+1)+"&size="+size+"&type="+type+"&keyword="+keyword;
		}
		else {//목록
			return "page="+(getEnd()+1)+"&size="+size;
		}
	}
	public String getQueryString(int page) {
		if(isSearch()) {//검색
			return "page="+page+"&size="+size+"&type="+type+"&keyword="+keyword;
		}
		else {//목록
			return "page="+page+"&size="+size;
		}
	}
	public int getStartRow() {
		return getFinishRow() - (size-1);
	}
	public int getFinishRow() {
		return page * size;
	}
	
	
}
