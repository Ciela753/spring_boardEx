package kr.co.codingmonkey.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class SampleServiceTests {
	@Setter @Autowired
	private SampleService service;
	
	//조인포인트 : 어드바이스가 지정될 수 있는 지점
	//포인트컷 : 어드바이스가 지정된 지점. 조건식처럼 생김
	//어드바이스 : 특정 조인포인트에서 실행되는 코드
	//aspect : 포인트컷 + 어드바이스
	
	//타겟 : 부가기능을 부여할 대상.
	//애스펙트 : 객체지향에서의 객체. 
	//부가될 기능을 정의한 어드바이스와 어드바이스를 어디에 적용할지 결정하는 포인트 컷을 갖고 있음
	//어드바이스 : 부가기능을 담은 구현체. 애스펙트가 무엇을 언제할지 정의하고 있음
	//포인트컷 : 부가기능이 적용될 대상(메소드)를 선정하는 방법
	//조인 포인트 : 어드바이스가 적용될 위치
	//프록시 : 타겟의 요청을 대신 받아주는 랩핑 오브젝트
	
	@Test
	public void testClass() {
		log.info(service);
		log.info(service.getClass().getName());
	}
	
	@Test
	public void testAdd() throws Exception {
		log.info(service.doAdd("123", "456"));
	}
	@Test
	public void testAddException() throws Exception {
		log.info(service.doAdd("123", "ABC"));
	}
}
