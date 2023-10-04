package com.kh.gogi.dto;



import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AddressDto {
	private int addressNo;
	private String addressId;
	private String addressName;
	private String addressPhone;
	private String addressPost;
	private String addressNormal;
	private String addressDetail;

//	
//	// 주소 정보를 저장하는 메서드
//    public void setAddressInfo(String addressName, String addressPhone, String addressPost, String addressNormal, String addressDetail) {
//        this.addressName = addressName;
//        this.addressPhone = addressPhone;
//        this.addressPost = addressPost;
//        this.addressNormal = addressNormal;
//        this.addressDetail = addressDetail;
//    }
}
