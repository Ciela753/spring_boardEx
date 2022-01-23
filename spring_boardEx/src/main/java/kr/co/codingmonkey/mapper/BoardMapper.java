package kr.co.codingmonkey.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import kr.co.codingmonkey.domain.BoardVO;
import kr.co.codingmonkey.domain.Criteria;

public interface BoardMapper {
//	@Select("select * from tbl_board where bno >0")
	public List<BoardVO> getList();
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(BoardVO board);
	
	public List<BoardVO> getListWithPaging(Criteria cri);
}