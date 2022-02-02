package kr.co.codingmonkey.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.co.codingmonkey.domain.Criteria;
import kr.co.codingmonkey.domain.ReplyVO;
import kr.co.codingmonkey.service.ReplyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {
	private ReplyService service;
	
	@PostMapping("new")
	public String create(@RequestBody ReplyVO vo) {
		log.info("create ::"+ vo);
		service.register(vo);
		log.info(vo);
		return "success";
	}
	
	@GetMapping("/pages/{bno}/{page}")
	public List<ReplyVO> getList(@PathVariable Long bno,
			@PathVariable int page) {
		log.info("getList.............");
		Criteria cri = new Criteria(page, 10);
		log.info(cri);
		
		return service.getList(cri, bno);
	}
	
	@GetMapping("{rno}")
	public ReplyVO get(@PathVariable Long rno) {
		log.info("get..::"+rno);
		return service.get(rno);
	}
	
	@DeleteMapping("{rno}")
	public String remove(@PathVariable Long rno) {
		log.info("remove::"+rno);
		service.remove(rno);
		
		return "success";
	}
	
	@PutMapping("{rno}")
	public String modify(@PathVariable Long rno, @RequestBody ReplyVO vo) {
		log.info("modify::"+vo);
		service.modify(vo);
		
		return "success";
	}
}
