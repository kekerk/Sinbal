package dao.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Board;

public interface BoardMapper {

	@Select("select ifnull(max(num),0) from board")
	int maxNum();

	@Insert("insert into board (num,name,pass,subject,content,file1,regdate,readcnt,ref,reflevel,refstep)"+
		 " values(#{num},#{name},#{pass},#{subject},#{content},#{fileurl},now(),0,#{ref},#{reflevel},#{refstep})")
	void insert(Board board);

	@Update("update board set readcnt=readcnt+1 where num=#{num}")
	void cntadd(Map<String, Integer> map);

	@Update("update board set refstep=refstep+1 where ref=#{ref} and refstep>#{refstep}")
	void upstep(Map<String, Integer> map);

	@Update("update board set name=#{name},subject=#{subject},content=#{content},file1=#{fileurl} where num=#{num}")
	void update(Board board);

	@Delete("delete from board where num=#{num}")
	void delete(Map<String, Integer> map);

}
