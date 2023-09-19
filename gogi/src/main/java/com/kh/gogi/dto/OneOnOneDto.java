package com.kh.gogi.dto;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OneOnOneDto {
	
private int oneNo,oneStatus;
private Date oneDate;
private String oneId,oneTitle,oneContent,oneCategory;
 }
