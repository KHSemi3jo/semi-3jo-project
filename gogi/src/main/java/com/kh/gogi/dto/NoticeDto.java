package com.kh.gogi.dto;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class NoticeDto {
private String  NoticeAdmin, NoticeTitle, NoticeWriter, NoticeContent;
private int NoticeNo;
private Date NoticeDate;
}
