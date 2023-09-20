package com.kh.gogi.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ShopAfterVO {
	 private String type, keyword;// 검색 분류 및 키워드
	 private int page =1; //현재 페이지 번호(기본 : 1)
	 private int size = 10;// 보여줄 게시판 글수(기본 : 10)
	 
	 private int count ; // 전체 글수 (다른 클래스에서 가져와야한다.)
	 
	 private int navigatorSize = 10; //하단 네이게이터 표시 갯수(기본 : 10)
	 
	 public boolean isSearch() {
		 return type != null && keyword != null;
	 }
	 public int getBegin() {
		return (page-1)/navigatorSize*navigatorSize+1; 
	 }
	 public int getEnd() {
		 int end= getBegin() +navigatorSize -1;
		 return Math.min(getPageCount(), end);
	 }
	 public boolean isFirst() {
		 return getBegin() ==1;
	 }
	 
	 public String getPrevQueryString() {
		 if(isSearch()) {//검색
			 return "page=" +(getBegin()-1)+"&type=?"+type+"&keyword="+keyword;
		 }
		 else {//목록
			return"page= "+(getBegin()-1);
		}
	 }
	 public int getPageCount() {
		 return (count-1)/size+1;
	 }
	 public boolean isLast() {
		 return getEnd() >= getPageCount();
	 }
	 public String getNextQueryString() {
		 if(isSearch()) {//검색
			 return "page=" +(getEnd()+1)+"&size="+size+"&type=?"+type+"&keyword="+keyword;
		 }
		 else {//목록
			return"page= "+(getEnd()+1)+"&size="+size;
		}
	 }
	 public String getQueryString(int page) {
		 if(isSearch()) {//검색
			 return "page=" +page+"&size="+size+"&type="+type+"&keyword="+keyword ;
		 }
		 else {//목록
			return"page="+page+"&size="+size;
		}
	 }
	 public int getStartRow() {
		 return getFinishRow()-(size -1);
	 }
	 public int getFinishRow() {
		 return page*size;
	 }
	}
