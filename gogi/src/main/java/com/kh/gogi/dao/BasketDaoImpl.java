package com.kh.gogi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.kh.gogi.dto.AttachDto;
import com.kh.gogi.dto.BasketDto;
import com.kh.gogi.dto.BasketListDto;
import com.kh.gogi.mapper.AttachMapper;
import com.kh.gogi.mapper.BasketListMapper;

@Component
public class BasketDaoImpl implements BasketDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private BasketListMapper basketListMapper;
	
	@Autowired
	private AttachMapper attachMapper;

	@Override
	public int sequence() {
		String sql = "select basket_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	@Override
	public void add(BasketDto basketDto) {
		String sql = "insert into basket(" 
					+ "basket_no, basket_member, " 
					+ "basket_listno, basket_count"
					+ ") values(?, ?, ?, ?)";
		Object[] data = { basketDto.getBasketNo(), basketDto.getBasketMember(), basketDto.getBasketListNo(),
				basketDto.getBasketCount() };
		jdbcTemplate.update(sql, data);
	}

	@Override
	public boolean delete(int basketNo) {
		String sql = "delete basket where basket_no = ?";
		Object[] data = { basketNo };
		return jdbcTemplate.update(sql, data) > 0;
	}
	
//	상품 이미지 찾기
	@Override
	public AttachDto findImage(int productNo) {
		String sql="select * from attach "
				+ "where attach_no = ( "
				+ "select attach_no from product_image "
				+ "where product_no = ?)";
		Object[] data = {productNo};
		List<AttachDto>list=jdbcTemplate.query(sql, attachMapper,data);
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public List<BasketListDto> selectList(String basketMember) {
		String sql = "select " 
				+ "basket_member," 
				+ "p.product_no, p.product_name, p.product_price,"
				+ "basket_no, basket_listno, basket_count , product_image.attach_no " 
				+ "from basket " 
				+ "left outer join product p "
				+ "on p.product_no = basket.basket_listno "
				+ "left outer join product_image "
				+ "on p.product_no = product_image.product_no "
				+ "where basket.basket_member = ? " 
				+ "order by basket.basket_member asc";
		Object[] data = {basketMember};
		return jdbcTemplate.query(sql, basketListMapper, data);
	}

	@Override
	public boolean isInBasket(String basketMember, int productNo) {
		String sql = "select count(*) from basket where basket_member = ? and basket_listno = ?";
        Object[] data = { basketMember, productNo };
        int count = jdbcTemplate.queryForObject(sql, Integer.class, data);
        return count > 0;
	}




}
