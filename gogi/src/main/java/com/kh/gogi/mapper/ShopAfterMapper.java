package com.kh.gogi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.gogi.dto.ShopAfterDto;

@Component
public class ShopAfterMapper implements RowMapper<ShopAfterDto>{

	@Override
	public ShopAfterDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ShopAfterDto shopAfterDto = new ShopAfterDto();
		shopAfterDto.setShopAfterAfterNo(rs.getObject("shopAfter_afterno",Integer.class));
		shopAfterDto.setShopAfterContent(rs.getString("shopAfter_content"));
		shopAfterDto.setShopAfterName(rs.getString("shopAfter_name"));
		shopAfterDto.setShopAfterDate(rs.getDate("shopAfter_date"));
		shopAfterDto.setShopAfterId(rs.getString("shopAfter_id"));
		shopAfterDto.setShopAfterLike(rs.getInt("shopAfter_like"));
		shopAfterDto.setShopAfterNo(rs.getInt("shopAfter_no"));
		shopAfterDto.setShopReplycount(rs.getInt("shopAfter_replycount"));

		return shopAfterDto;
	}

}
