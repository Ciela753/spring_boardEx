package kr.co.codingmonkey.sample;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Component
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Restaurant {
	@Setter @Autowired
	private Chef chef;
}
