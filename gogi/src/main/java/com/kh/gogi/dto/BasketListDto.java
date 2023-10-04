package com.kh.gogi.dto;

import lombok.Data;

@Data
public class BasketListDto {
	private int basketNo;
	private int basketListNo;
	private String basketMember;
	private int basketCount;
	private int productNo;
	private String productName;
	private int productPrice;
	private boolean image;
}
