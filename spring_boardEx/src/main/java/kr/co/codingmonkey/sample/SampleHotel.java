package kr.co.codingmonkey.sample;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Component
@ToString
@Getter
public class SampleHotel {
	private Chef chef;
	
	@Autowired
	public SampleHotel(Chef chef) {
		this.chef = chef;
	}
}
