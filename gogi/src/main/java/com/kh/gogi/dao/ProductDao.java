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
	
	List<ProductDto> selectListBypage(int page);
	List<ProductDto> selectListBypage(ProductVO vo);
	
//	int countList();
	int countList(ProductVO  vo);
	

}
