package com.kh.gogi.dto;



import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AddressDto {
	private int addressNo;
	private String addressId;
	private String addressPost;
	private String addressNormal;
	private String addressDetail;

}
