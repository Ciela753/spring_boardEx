package kr.co.codingmonkey.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.codingmonkey.domain.BoardAttachVO;
import kr.co.codingmonkey.domain.BoardVO;
import kr.co.codingmonkey.domain.Criteria;
import kr.co.codingmonkey.mapper.BoardAttachMapper;
import kr.co.codingmonkey.mapper.BoardMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	@Setter @Autowired
	private BoardMapper mapper;
	
	@Setter @Autowired
	private BoardAttachMapper attachMapper;
	
	@Transactional
	@Override
	public void register(BoardVO board) {
		log.info("register..........." + board);
		
		mapper.insertSelectKey(board);
		
		board.getAttachList().forEach(attach -> {
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
			log.info("=======================");
			log.info("board bno : "+board.getBno());
		});
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get........."+bno);
		
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify......."+board);
		return mapper.update(board) == 1;
	}

	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("remove........." + bno);
		
		attachMapper.deleteAll(bno);
		
		return mapper.delete(bno)==1;
	}

//	@Override
//	public List<BoardVO> getList() {
//		log.info("getList..............");
//		
//		return mapper.getList();
//	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("get List with criteria: "+cri);
		
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("get Attach list by bno " + bno);
		
		return attachMapper.findByBno(bno);
	}

}
