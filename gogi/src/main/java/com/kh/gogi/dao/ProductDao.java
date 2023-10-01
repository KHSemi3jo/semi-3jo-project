package com.kh.gogi.dao;

import java.util.List;

import com.kh.gogi.dto.AttachDto;
import com.kh.gogi.dto.ProductDto;
import com.kh.gogi.vo.ProductVO;

public interface ProductDao {
	int sequence();
	void insert(ProductDto productDto);
	ProductDto selectOne(int productNo);
	boolean delete(int productNo);
	boolean update(ProductDto productDto);
	List<ProductDto> selectList();
	
	void connect(int productNo, int attachNo);
	AttachDto findImage(int productNo);
	
	int countList(ProductVO  vo);
	List<ProductDto> selectListBypage(ProductVO vo);
	
	List<ProductDto> selectByProductType(String productType);//카테고리로 상품찾기
	List<ProductDto> selectDomesticBeefProduct(ProductVO vo); //국내산 소고기
	int countDomesticBeefProduct(ProductVO vo);
	List<ProductDto> selectImportedBeefProduct(ProductVO vo);// 수입산 소고기 
	int countImportedBeefProduct(ProductVO vo);
	List<ProductDto> selectPorkProduct(ProductVO vo);// 돼지고기
	int countPorkProduct(ProductVO vo);

}
