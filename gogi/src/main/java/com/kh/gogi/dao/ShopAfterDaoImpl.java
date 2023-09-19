package com.kh.gogi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.gogi.dto.ShopAfterDto;
import com.kh.gogi.mapper.ShopAfterMapper;

@Repository
public class ShopAfterDaoImpl implements ShopAfterDao {
	@Autowired
	ShopAfterMapper shopAfterMapper;
	@Autowired
	JdbcTemplate tem;

	@Override
	public int sequence() {
		String sql = "select shopAfter_seq.nextval from dual ";
		return tem.queryForObject(sql, int.class);
	}

	@Override
	public void add(ShopAfterDto shopAfterDto) {
		String sql = "insert into shopAfter(shopAfter_no,"
				+ " shopAfter_name ,shopAfter_content) "
				+ "values(?,?,?)";
		Object[] data = {shopAfterDto.getShopAfterNo(),
				shopAfterDto.getShopAfterName(),shopAfterDto.getShopAfterContent()};
	tem.update(sql, data);
	}

	@Override
	public boolean delete(int shopAfterNo) {
		String sql ="select * from shopAfter where shopAfter_no =?";
		Object[] data = {shopAfterNo};
		return tem.update(sql, data)>0;
	}

	@Override
	public List<ShopAfterDto> list() {
		String sql ="select * from shopAfter order by shopAfter_no desc";
		return tem.query(sql, shopAfterMapper);
	}

	@Override
	public boolean fix(ShopAfterDto shopAfterDto) {
		String sql = "update shopAfter set shopAfter_name = ?, shopAfter_content = ?  where shopAfter_no = ?";
		Object[] data = {shopAfterDto.getShopAfterName(), 
				shopAfterDto.getShopAfterContent(), shopAfterDto.getShopAfterNo()};
		return tem.update(sql, data)>0;
	}

	@Override
	public ShopAfterDto detail(int shopAfterNo) {
		String sql = "select * from shopAfter where shopAfter_no = ?";
		Object[] data = {shopAfterNo};
	 List<ShopAfterDto> list = tem.query(sql, shopAfterMapper, data);
 		return list.isEmpty() ? null : list.get(0);
	}

}
