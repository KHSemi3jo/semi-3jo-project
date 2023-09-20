package com.kh.gogi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.gogi.dto.ShopAfterListDto;

@Component
public class ShopAfterListMapper implements RowMapper<ShopAfterListDto>{

	@Override
	public ShopAfterListDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ShopAfterListDto shopAfterListDto = new ShopAfterListDto();
		shopAfterListDto.setShopAfterAfterNo(rs.getInt("shopAfter_afterno"));
		shopAfterListDto.setShopAfterContent(rs.getString("shopAfter_content"));
		shopAfterListDto.setShopAfterDate(rs.getDate("shopAfter_date"));
		shopAfterListDto.setShopAfterId(rs.getString("shopAfter_id"));
		shopAfterListDto.setShopAfterLike(rs.getInt("shopAfter_like"));
		shopAfterListDto.setShopAfterNo(rs.getInt("shopAfter_no"));
		shopAfterListDto.setShopReplycount(rs.getInt("shopAfter_replycount"));
		shopAfterListDto.setShopReplyDepth(rs.getInt("shopAfter_depth"));
		shopAfterListDto.setShopReplyGroup(rs.getInt("shopAfter_group"));
		shopAfterListDto.setShopReplyParent(rs.getObject("shopAfter_parent",Integer.class));
		
		return shopAfterListDto;
	}

}
