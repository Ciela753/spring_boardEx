package kr.co.codingmonkey.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.codingmonkey.domain.Criteria;
import kr.co.codingmonkey.domain.ReplyPageDTO;
import kr.co.codingmonkey.domain.ReplyVO;
import kr.co.codingmonkey.mapper.BoardMapper;
import kr.co.codingmonkey.mapper.ReplyMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {

	@Setter @Autowired
	private ReplyMapper mapper;
	
	@Setter @Autowired
	private BoardMapper boardMapper;
	
	@Transactional
	@Override
	public int register(ReplyVO vo) {
		log.info("register..........." + vo);
		
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		log.info("get.........."+ rno);
		
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		log.info("modify.........."+ vo);
		
		return mapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		log.info("modify.........."+ rno);
		
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("get Reply List of a Board"+bno);
		
		return mapper.getListWithPaging(cri, bno);
	}
}
