package com.kh.gogi.dto;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class AddressDto {
	private String addressPost;
	private String addressNormal;
	private String addressDetail;

}
