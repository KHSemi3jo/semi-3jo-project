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
		String sql = "insert into shopAfter(shopAfter_no," + " shopAfter_name ,shopAfter_content) " + "values(?,?,?)";
		Object[] data = { shopAfterDto.getShopAfterNo(), shopAfterDto.getShopAfterName(),
				shopAfterDto.getShopAfterContent() };
		tem.update(sql, data);
	}

	@Override
	public boolean delete(int shopAfterNo) {
		String sql = "delete from shopAfter where shopAfter_no =?";
		Object[] data = { shopAfterNo };
		return tem.update(sql, data) > 0;
	}

	@Override
	public List<ShopAfterDto> list() {
		String sql = "select * from shopAfter order by shopAfter_no desc";
		return tem.query(sql, shopAfterMapper);
	}

	@Override
	public boolean fix(ShopAfterDto shopAfterDto) {
		String sql = "update shopAfter set shopAfter_name = ?, shopAfter_content = ?  where shopAfter_no = ?";
		Object[] data = { shopAfterDto.getShopAfterName(), shopAfterDto.getShopAfterContent(),
				shopAfterDto.getShopAfterNo() };
		return tem.update(sql, data) > 0;
	}

	@Override
	public ShopAfterDto detail(int shopAfterNo) {
		String sql = "select * from shopAfter where shopAfter_no = ?";
		Object[] data = { shopAfterNo };
		List<ShopAfterDto> list = tem.query(sql, shopAfterMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public boolean updateShopAfterReplyCount(int shopAfterNo) {
		String sql = "update shopAfter set shopAfter_replycount= ("
				+ " select count(*) from reply where reply_origin = ?) " + "where shopAfter_no = ?";
		Object[] data = { shopAfterNo, shopAfterNo };
		return tem.update(sql, data) > 0;
	}

	@Override
	public int countList() {
		String sql = "select count(*) from shopAfter";
		return tem.queryForObject(sql, int.class);
	}

	@Override
	public int countList(String type, String keyword) {
		String sql = "select count(*) from shopAfter where instr(" + type + ",?) > 0";
		Object[] ob = { keyword };
		return tem.queryForObject(sql, int.class, ob);
	}

	@Override
	public List<ShopAfterDto> search(String type, String keyword) {
		String sql = "select * from board_list where instr(#1, ?) > 0" + " order by board_no desc";
		sql = sql.replace("#1", type); 
		Object[] ob = { keyword };
		List<ShopAfterDto> list = tem.query(sql, shopAfterMapper, ob);
		return list;
	}

	@Override
	public List<ShopAfterDto> selectListByPage(String type, String keyword, int page) {
		int begin = page * 10 - 9;
		int end = page * 10;
		String sql = "select * from (" + " select rownum rn, TMP.* from (" + " select * from shopAfter_list"
				+ " where instr(" + type + ", ?) > 0" + " connect by Prior  shopAfter_no = shopAfter_parent"
				+ " start WITH shopAfter_parent is NULL " + " order siblings by shopAfter_group desc, shopAfter_no asc" + ")TMP"
				+ ") where rn between ? and ?";

		Object[] ob = { keyword, begin, end };
		return tem.query(sql, shopAfterMapper, ob);
	}

	@Override
	public List<ShopAfterDto> selectListByPage(int page) {
		String sql = "select * from (" + "select rownum rn, TMP.* from (" + "select * from shopAfter_list "
				+ "connect by prior shopAfter_no=shopAfter_parent " + "start with shopAfter_parent is null "
				+ "order siblings by shopAfter_group desc, shopAfter_no asc" + ")TMP" + ") where rn between ? and ?";
		Object[] ob = { page * 10 - 9, page * 10 };
		return tem.query(sql, shopAfterMapper, ob);

	}

}
