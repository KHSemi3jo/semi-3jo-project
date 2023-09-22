package com.kh.gogi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.kh.gogi.dto.PickDto;
import com.kh.gogi.dto.PickListDto;
import com.kh.gogi.mapper.PickListMapper;

@Component
public class PickDaoImpl implements PickDao{
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private PickListMapper pickListMapper;

	@Override
	public int sequence() {
		String sql = "select pick_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	@Override
	public void add(PickDto pickDto) {
		String sql = "insert into pick("
				+ "pick_no, pickProd_no, pickmember_id"
				+ ") values(?, ?, ?)";
		Object[] data = {
				pickDto.getPickNo(), pickDto.getPickProdNo(), pickDto.getPickMemberId()
		};
		jdbcTemplate.update(sql, data);
	}

	@Override
	public boolean delete(int pickNo) {
		String sql = "delete pick where pick_no = ?";
		Object[] data = {pickNo};
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Override
	public List<PickListDto> selectList() {
		String sql = "select "
				+ "pickmember_id,"
				+ "product_no, product_name, product_price,"
				+ "pick_no, pickProd_no "
				+ "from pick "
				+ "left outer join product "
				+ "on product.product_no = pick.pickProd_no "
				+ "order by pick.pickmember_id asc";
		return jdbcTemplate.query(sql, pickListMapper);
	}

}
