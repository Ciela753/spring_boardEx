package kr.co.codingmonkey.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.codingmonkey.domain.AttachFileDTO;
import kr.co.codingmonkey.domain.BoardAttachVO;
import kr.co.codingmonkey.domain.BoardVO;
import kr.co.codingmonkey.domain.Criteria;
import kr.co.codingmonkey.domain.PageDTO;
import kr.co.codingmonkey.service.BoardService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	private BoardService service;
	
	//게시물 목록 전달하기 위해 model을 파라미터로 지정
//	@GetMapping("/list")
//	public void list(Model model) {
//		log.info("list");
//		
//		//url상 데이터 유지
//		model.addAttribute("list", service.getList());
//	}
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list: "+cri);
		
		//url상 데이터 유지
		model.addAttribute("list", service.getList(cri));
//		model.addAttribute("page", new PageDTO(cri, 123));
		
		int total = service.getTotal(cri);
		
		log.info("total: "+total);
		
		model.addAttribute("page", new PageDTO(cri, total));
		
		
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	//새롭게 등록된 게시물의 번호를 같이 전달하기 위해 redirectAttributes를 쓴다
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
//		
//		
//		if(board.getAttachList() != null) {
//			board.getAttachList().forEach(attach -> log.info(attach));
//		}
//		

		log.info("register: "+board);
		service.register(board);
//		url상 데이터소멸
		log.info("======================");
		rttr.addFlashAttribute("result", board.getBno());
		
		return "redirect:/board/list";
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("/get or modify");
		model.addAttribute("board", service.get(bno));
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("modify: "+ board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri, String writer) {
		log.info("remove........."+bno);
		List<BoardAttachVO> list = service.getAttachList(bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/board/list";
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		log.info("file Name : "+fileName);
		File file = new File("C:\\upload\\" + fileName);
		
		log.info("flie : " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders headers = new HttpHeaders();
			
			headers.add("content-Type", Files.probeContentType(file.toPath()));
			
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
		} catch (IOException e ) {
			e.printStackTrace();
		}
		return result;
	}
	
	@GetMapping("getAttachList/{bno}")
	public @ResponseBody List<BoardAttachVO> getAttachList(@PathVariable Long bno){
		log.info("getAttachList "+bno);
		return service.getAttachList(bno);
	}
}
