package com.kh.gogi.vo;

import lombok.Data;

//VO(Value Object)
//- 내 입맛대로 데이터를 모아서 저장하는 클래스(DB무관)
//- 등록하지 않고 필요할 때마다 만들어서 사용
@Data
public class PaginationVO {
	private String type, keyword; //검색 분류 및 키워드
	private int page = 1; //현재 페이지 번호(기본:1)
	private int size = 20; //보여줄 게시판의 글 수(기본:20)
	private int count; //전체 글 수
	private int navigatorSize = 10; //하단 네비게이터 표시 개수(기본:10)
	
	public boolean isSearch() {
		return type != null && keyword != null;
	}
	public int getBegin() {
		return (page-1)/navigatorSize * navigatorSize + 1;
	}
	public int getEnd() {
		int end = getBegin() + navigatorSize - 1;
		return Math.min(getPageCount(), end);
	}
	public boolean isFirst() {
		return getBegin() == 1;
	}
	public String getPrevQueryString() {
		if(isSearch()) { //검색이면
		return "page="+ (getBegin()-1) +"&size=" +size+ "&type=" + type + "&keyword=" + keyword;
		}
		else { //목록이면
			return "page=" + (getBegin()-1) + "&size=" +size;
		}
	}
	public int getPageCount() {
		return (count-1)/size + 1;
	}
	public boolean isLast() {
		return getEnd() >= getPageCount();
	}
	
	public String getnextQueryString() {
		if(isSearch()) { //검색이면
		return "page="+ (getEnd()+1) + "&size=" +size+ "&type=" + type + "&keyword=" + keyword;
		}
		else { //목록이면
			return "page=" + (getEnd()+1)+ "&size=" +size;
		}
	}
	
	public String getQueryString(int page) { //-> 현재페이지
		if(isSearch()) { //검색이면
			return "page="+ page + "&size=" +size+ "&type=" + type + "&keyword=" + keyword; //헤당페이지 내놔라
			}
			else { //목록이면
				return "page=" + page +"&size=" +size;
			}
		}
	
	public int getStartRow() {
		return getFinishRow() - (size-1);
	}
	public int getFinishRow() {
		return page * size;
	}
	}
