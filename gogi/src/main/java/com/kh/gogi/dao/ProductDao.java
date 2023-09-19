package com.kh.gogi.dao;

import java.util.List;

import com.kh.gogi.dto.AttachDto;
import com.kh.gogi.dto.ProductDto;

public interface ProductDao {
	int sequence();
	void insert(ProductDto productDto);
	ProductDto selectOne(int productNo);
	boolean delete(int productNo);
	boolean update(ProductDto productDto);
	List<ProductDto>selectList();
	
	void connect(int productNo, int attachNo);
	AttachDto findImage(int productNo);

}
