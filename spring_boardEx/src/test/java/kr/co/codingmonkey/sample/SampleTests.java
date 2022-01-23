package kr.co.codingmonkey.sample;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
//지정된 클래스나 문자열을 이용해서 필요한 객체들을 스프링 내에 객체로 등록하게 됨
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class SampleTests {
	//해당 인스턴스변수가 스프링으로부터 자동으로 주입해 달라는 표시
	//obj변수에 restaurant 타입의 객체를 주입하게 된다.
	@Setter @Autowired
	private Restaurant restaurant;
	
	@Test
	public void testExist() {
		assertNotNull(restaurant);
		
		log.info(restaurant);
		log.info("==============");
		log.info(restaurant.getChef());
	}

}
