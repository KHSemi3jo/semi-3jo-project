package com.kh.gogi.dao;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.gogi.dto.AttachDto;
import com.kh.gogi.dto.ProductDto;
import com.kh.gogi.mapper.AttachMapper;
import com.kh.gogi.mapper.ProductListMapper;
import com.kh.gogi.mapper.ProductMapper;
import com.kh.gogi.vo.ProductVO;

@Repository
public class ProductDaoImpl implements ProductDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ProductMapper productMapper;
	
	@Autowired
	private AttachMapper attachMapper;
	
	@Autowired
	private ProductListMapper productListMapper;
	
	
//	상품번호 생성 기능
	@Override
	public int sequence() {
		String sql="select product_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
//	상품 등록
	@Override
	public void insert(ProductDto productDto) {
		String sql = "insert into product(product_no,product_name,product_price, "
						+ "product_weight,product_origin,product_type) "
						+ " values(?,?,?,?,?,?)";
		Object[] data = {
				productDto.getProductNo(),productDto.getProductName(),productDto.getProductPrice(),
				productDto.getProductWeight(),productDto.getProductOrigin(),productDto.getProductType()
		};
		jdbcTemplate.update(sql,data);
	}
	
//	상품 + 이미지 연결
	@Override
	public void connect(int productNo, int attachNo) {
		String sql="insert into product_image values(?,?)";
		Object[] data = {productNo,attachNo};
		jdbcTemplate.update(sql,data);
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
	
//	상품 상세조회
	@Override
	public ProductDto selectOne(int productNo) {
		String sql="select p.*, pd.attach_no from "
				+ " product p left outer join product_image pd "
				+ " on p.product_no = pd.product_no "
				+ " where p.product_no=?";
		Object[] data = {productNo};
		List<ProductDto>list = jdbcTemplate.query(sql, productMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
//	상품 목록조회
	@Override
	public List<ProductDto> selectList() {
		String sql = "select  p.*, pd.attach_no from "
				+ " product p left outer join product_image pd "
				+ "on p.product_no = pd.product_no "
				+ "order by p.product_no asc";
		return jdbcTemplate.query(sql, productMapper);
	}
	
//	상품 삭제
	@Override
	public boolean delete(int productNo) {
		String sql="delete product where product_no=?";
		Object[]data= {productNo};
		return jdbcTemplate.update(sql,data)>0;
	}
	
//	상품 수정
	@Override
	public boolean update(ProductDto productDto) {
		String sql = "update product set product_name=?,product_price=?, "
						+ "product_weight=?,product_origin=?,product_type=?  where product_no=?";
		Object[]data= {
				productDto.getProductName(),productDto.getProductPrice(),
					productDto.getProductWeight(),productDto.getProductOrigin(),
					productDto.getProductType(),productDto.getProductNo()
						};
		return jdbcTemplate.update(sql,data)>0;
	}


	@Override
	public int countList(ProductVO vo) {
		if(vo.isSearch()) {
			String sql = "select count(*) from product "
					+ "where instr("+vo.getType()+",?)>0";
			Object[]data= {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class,data);
		}
		else {
			String sql = "select count(*) from product";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}

	@Override
	public List<ProductDto> selectListBypage(ProductVO vo) {
		
		if(vo.isSearch()) {//검색할때
			String sql = "SELECT * FROM ( "
	                + "SELECT ROWNUM AS rn, TMP.* FROM ( "
	                + "SELECT * FROM product_list "
	                + "where instr("+vo.getType()+",?)>0"
	                + "ORDER  BY product_no asc,"+vo.getType()+" ASC "
	                + ") TMP "
	                + ") WHERE rn BETWEEN ? AND ?";
			Object[] data = {vo.getKeyword(),vo.getStartRow(),vo.getFinishRow()};
			return jdbcTemplate.query(sql, productListMapper,data);
		}
		else {
			String sql = "SELECT * FROM ( "
	                + "SELECT ROWNUM AS rn, TMP.* FROM ( "
	                + "SELECT * FROM product_list "
	                + "ORDER  BY product_no ASC "
	                + ") TMP "
	                + ") WHERE rn BETWEEN ? AND ?";
			Object[] data = {vo.getStartRow(),vo.getFinishRow()};
			return jdbcTemplate.query(sql, productListMapper,data);
		}
	}
	
	@SuppressWarnings("deprecation")
	@Override
	public List<ProductDto> selectByProductType(String productType) {
		String sql = "SELECT p.*, pd.attach_no "
	            + "FROM product p "
	            + "LEFT OUTER JOIN product_image pd ON p.product_no = pd.product_no "
	            + "WHERE p.product_type = ? "
	            + "ORDER BY p.product_no ASC";
		return jdbcTemplate.query(sql,new Object[] {productType}, productListMapper);
	}

	@Override
	public List<ProductDto> selectDomesticBeefProduct(ProductVO vo) {
		vo.setProductType("국내산소고기");
		return selectByProductType(vo.getProductType());
	}

	@Override
	public List<ProductDto> selectImportedBeefProduct(ProductVO vo) {
		vo.setProductType("수입산소고기");
		return selectByProductType(vo.getProductType());
	}

	@Override
	public List<ProductDto> selectPorkProduct(ProductVO vo) {
		vo.setProductType("돼지고기");
		return selectByProductType(vo.getProductType());
	}

	@Override
	public int countDomesticBeefProduct(ProductVO vo) {
		if(vo.isSearch()) {
			String sql = "select count(*) from product where product_type = '국내산소고기' "
					+ "and instr("+vo.getType()+",?)>0";
			Object[]data= {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class,data);
		}
		else {
			String sql = "select count(*) from product where product_type = '국내산소고기'";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}

	@Override
	public int countImportedBeefProduct(ProductVO vo) {
		if(vo.isSearch()) {
			String sql = "select count(*) from product where product_type = '수입산소고기' "
					+ "and instr("+vo.getType()+",?)>0";
			Object[]data= {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class,data);
		}
		else {
			String sql = "select count(*) from product where product_type = '수입산소고기'";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}

	@Override
	public int countPorkProduct(ProductVO vo) {
		if(vo.isSearch()) {
			String sql = "select count(*) from product where product_type = '돼지고기' "
					+ "and instr("+vo.getType()+",?)>0";
			Object[]data= {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class,data);
		}
		else {
			String sql = "select count(*) from product where product_type = '돼지고기'";
			return jdbcTemplate.queryForObject(sql, int.class);
	}
	}

		
	
}
