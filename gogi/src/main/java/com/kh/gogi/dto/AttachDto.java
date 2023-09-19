package com.kh.gogi.dto;

import java.util.Date;

import lombok.Data;

@Data
public class AttachDto {
	private int attachNo;
	private String attachName;
	private long attachSize;
	private String attachType;
	private Date attachTime;
}
