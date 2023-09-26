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
import com.kh.gogi.vo.ProductVO;

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
				File dir = new File(home, "Gogi");
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
		public ResponseEntity<ByteArrayResource> image(@RequestParam int productNo) throws IOException{
			
			AttachDto attachDto = productDao.findImage(productNo);//상품번호로 파일번호 찾기
//			if(attachDto == null) {
//				return ResponseEntity.notFound().build();//파일번호가 없으면 404 반환
//			}
			String home=System.getProperty("user.home");
			File dir = new File(home, "Gogi");
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
				return"/WEB-INF/views/product/detail.jsp";
		}
		
//		//상품 목록 페이지
//				@RequestMapping("/list")
//				public String list(Model model) {
//					List<ProductDto>list = productDao.selectList();
//					model.addAttribute("list",list);
//					return"/WEB-INF/views/product/list.jsp";
//				}
		
		//상품 목록 페이지
		@RequestMapping("/list")
		public String list(Model model,
								@ModelAttribute(name = "vo") ProductVO vo) {
			int count=productDao.countList(vo);
			vo.setCount(count);
			
			List<ProductDto>list = productDao.selectListBypage(vo);
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
		public String edit(@ModelAttribute ProductDto productDto,
								@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
			 productDao.update(productDto);//상품 정보 변경
			 
			 if(!attach.isEmpty()) { //파일이 있으면
				 //파일 삭제
				 AttachDto attachDto = productDao.findImage(productDto.getProductNo());
				 String home = System.getProperty("user.home");
				 File dir = new File(home, "Gogi");
				 
				 if(attachDto != null) {
					 attachDao.delete(attachDto.getAttachNo());
				 
				 	File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
				 	target.delete();
			 }
			 
			 //파일 추가 및 연결
			 int attachNo = attachDao.sequence();
			 
			 File insertTarget = new File(dir,String.valueOf(attachNo));
			 attach.transferTo(insertTarget);
			 
			 AttachDto insertDto = new AttachDto();
			 insertDto.setAttachNo(attachNo);
			 insertDto.setAttachName(attach.getOriginalFilename());
			 insertDto.setAttachSize(attach.getSize());
			 insertDto.setAttachType(attach.getContentType());
			 attachDao.insert(insertDto);
			 
			 productDao.connect(productDto.getProductNo(), attachNo);//상품 번호 + 파일 연결
			 }
			 
			 return "redirect:detail?productNo="+productDto.getProductNo();
		}
		
		//상품 삭제 페이지
		@RequestMapping("/delete")
		public String delete(@RequestParam int productNo) {
			AttachDto attachDto = productDao.findImage(productNo);
			productDao.delete(productNo);//상품+이미지 삭제
			
			//이미지가 있을 경우에만 이미지 삭제
			if(attachDto != null) {
				
				String home = System.getProperty("user.home");
				File dir = new File(home, "Gogi");
				File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
				target.delete();
				
				attachDao.delete(attachDto.getAttachNo());//파일 삭제
			}
			return "redirect:/product/list";
		}
		
		
		
		
	
}
