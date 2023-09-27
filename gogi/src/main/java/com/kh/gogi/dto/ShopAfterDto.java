package com.kh.gogi.dto;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ShopAfterDto {
private	Integer shopAfterAfterNo;
private	int shopAfterNo;
private	String shopAfterId;
private	String shopAfterName;
private	String shopAfterContent;
private	int shopAfterLike;
private	Date shopAfterDate;
private	int shopReplycount;


}
