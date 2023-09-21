package com.kh.gogi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ProductDto {
	private int productNo;
	private String productName;
	private int productPrice;
	private int productWeight;
	private String productOrigin;
	private Date productExpire;
	private String productType;
	private Date productDate;
	private boolean image;
	private int page;
}
