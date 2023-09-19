package com.kh.gogi.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.gogi.dao.AttachDao;
import com.kh.gogi.dao.ProductDao;
import com.kh.gogi.dto.AttachDto;
import com.kh.gogi.dto.ProductDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/product")
public class ProductController {
	
		@Autowired
		private ProductDao productDao;
		
		@Autowired
		private AttachDao attachDao;
		
		//등록
		@GetMapping("/add")
		public String add() {
			return "/WEB-INF/views/product/add.jsp";
		}
		@PostMapping("/add")
		public String add(@ModelAttribute ProductDto productDto,
								@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
			
			//상품 등록
			int productNo = productDao.sequence();
			productDto.setProductNo(productNo);
			productDao.insert(productDto);
			
			if(!attach.isEmpty()) { //파일이 있으면
				int attachNo = attachDao.sequence();
				
				String home=System.getProperty("user.home");
				File dir = new File(home, "upload");
				dir.mkdirs();
				File target = new File(dir, String.valueOf(attachNo));
				attach.transferTo(target);
				
				AttachDto attachDto = new AttachDto();
				attachDto.setAttachNo(attachNo);
				attachDto.setAttachName(attach.getOriginalFilename());
				attachDto.setAttachSize(attach.getSize());
				attachDto.setAttachType(attach.getContentType());
				attachDao.insert(attachDto);
				
				//연결
				productDao.connect(productNo, attachNo);
			}
			
			return "redirect:/product/add";
		}
		
		@ResponseBody
		@RequestMapping("/image")
		public ResponseEntity<ByteArrayResource> image(@RequestParam int proudctNo) throws IOException{
			
			AttachDto attachDto = productDao.findImage(proudctNo);//상품번호로 파일번호 찾기
			if(attachDto == null) {
				return ResponseEntity.notFound().build();//파일번호가 없으면 404 반환
			}
			String home=System.getProperty("user.home");
			File dir = new File(home, "upload");
			File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
			
			byte[] data = FileUtils.readFileToByteArray(target);//실제 파일 불러오기
			ByteArrayResource resource = new ByteArrayResource(data);
			
			return ResponseEntity.ok()
					.header(HttpHeaders.CONTENT_ENCODING,StandardCharsets.UTF_8.name())
					.contentLength(attachDto.getAttachSize())
					.header(HttpHeaders.CONTENT_TYPE, attachDto.getAttachType())
					.header(HttpHeaders.CONTENT_DISPOSITION,
							ContentDisposition.attachment().filename(attachDto.getAttachName(),StandardCharsets.UTF_8).build().toString()
							)
					.body(resource);
		}
		
		//상품 상세 페이지
		@RequestMapping("/detail")
		public String detail(@RequestParam int productNo, Model model) {
				ProductDto productDto = productDao.selectOne(productNo);
				model.addAttribute("productDto",productDto);
				return"/WEB-INF/view/product/detail.jsp";
		}
		
		//상품 목록 페이지
		@RequestMapping("/list")
		public String list(Model model) {
			List<ProductDto>list = productDao.selectList();
			model.addAttribute("list",list);
			return"/WEB-INF/views/product/list.jsp";
		}
		
		//상품 수정 페이지
		@GetMapping("/edit")
		public String edit(@RequestParam int productNo,Model model) {
			ProductDto productDto = productDao.selectOne(productNo);
			model.addAttribute("productDto",productDto);
			return"/WEB-INF/views/product/edit.jsp";
		}
		@PostMapping("/edit")
		public String edit(@ModelAttribute ProductDto productDto) {
			boolean result= productDao.update(productDto);
			if(result) {
				return "redirect:detail?productNo="+productDto.getProductNo();
			}
			else {
				return"redirect:error";
			}
		}
		
		//상품 삭제 페이지
		@RequestMapping("/delete")
		public String delete(@RequestParam int productNo) {
			AttachDto attachDto = productDao.findImage(productNo);
			productDao.delete(productNo);//상품+이미지 삭제
			
			if(attachDto != null) {
				
				String home = System.getProperty("user.home");
				File dir = new File(home, "upload");
				File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
				target.delete();
				
				attachDao.delete(attachDto.getAttachNo());//파일 삭제
			}
			return "redirect:/product/list";
		}
		
		
		
		
	
}
