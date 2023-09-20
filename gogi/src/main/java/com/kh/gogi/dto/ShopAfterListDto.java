package com.kh.gogi.dto;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ShopAfterListDto {
private	int shopAfterAfterNo;
private	int shopAfterNo;
private	String shopAfterId;

private	String shopAfterContent;
private	int shopAfterLike;
private	Date shopAfterDate;
private	int shopReplycount;

private	int shopReplyGroup;
private	Integer shopReplyParent;
private	int shopReplyDepth;
}
