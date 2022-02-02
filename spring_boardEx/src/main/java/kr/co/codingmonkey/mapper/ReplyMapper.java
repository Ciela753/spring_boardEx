package kr.co.codingmonkey.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.codingmonkey.domain.Criteria;
import kr.co.codingmonkey.domain.ReplyVO;

public interface ReplyMapper {

	public int insert(ReplyVO vo);
	
	public ReplyVO read(Long rno);
	
	public int delete(Long rno);
	
	public int update(ReplyVO reply);
	
	public List<ReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("bno") Long bno);
}
