package com.kh.gogi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.gogi.dto.ProductDto;

@Component
public class ProductListMapper implements RowMapper<ProductDto> {

	@Override
	public ProductDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ProductDto productDto= new ProductDto();
		productDto.setProductNo(rs.getInt("product_no"));
		productDto.setProductName(rs.getString("product_name"));
		productDto.setProductPrice(rs.getInt("product_price"));
		productDto.setImage(rs.getObject("attach_no")!=null);
		return productDto;
	}

}
