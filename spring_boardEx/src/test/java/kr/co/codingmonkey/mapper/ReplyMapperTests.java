package kr.co.codingmonkey.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import kr.co.codingmonkey.domain.Criteria;
import kr.co.codingmonkey.domain.ReplyVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	@Setter @Autowired
	private ReplyMapper mapper;
	
	@Test
	public void testCreate() {
		IntStream.rangeClosed(1, 10).forEach(i->{
			
		ReplyVO vo = new ReplyVO();
		
		vo.setBno(768L);
		vo.setReply("댓글 테스트" + i);
		vo.setReplyer("replyer"+i);
		
		mapper.insert(vo);
		
		});
	}
	
	@Test
	public void testRead() {
		ReplyVO vo = new ReplyVO();
		
		vo = mapper.read(5L);
		
		log.info(vo);
	}
	
	@Test
	public void testDelete() {
		Long targetRno =1L;
		
		mapper.delete(targetRno);
	}
	
	@Test
	public void testUpdate() {
		Long targetRno = 10L;
		
		ReplyVO vo = mapper.read(targetRno);
		vo.setReply("Update reply ");
		
		int count = mapper.update(vo);
		
		log.info("UPDATE COUNT: " + count);
	}
	
	@Test
	public void testMapper() {
		log.info("===================");
		log.info(mapper);
	}
	
	@Test
	public void testList() {
		Criteria cri = new Criteria();
		
		List<ReplyVO> relies = mapper.getListWithPaging(cri, 213L);
		
		relies.forEach(reply -> log.info(reply));
	}
	
	@Test
	public void testList2() {
		Criteria cri = new Criteria(2, 10);
		
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 213L);
		
		replies.forEach(reply -> log.info(reply));
	}
}
