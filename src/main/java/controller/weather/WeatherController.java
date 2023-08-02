package controller.weather;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import service.weather.WeatherService;

@Controller
public class WeatherController {
	
	private WeatherService weatherService;
	
	public WeatherController(WeatherService weatherService) {
		this.weatherService = weatherService;
	}

	@RequestMapping("/")
	public String main(Model model) {
		model.addAttribute("depth1", weatherService.selectDepth1());
		return "customer/weather/weather";
	}
	
	@RequestMapping(value="weather/depth2", produces = "application/json;charset=utf8")
	@ResponseBody
	public List<String> selectDepth2(String depth1, Model model) {
		return weatherService.selectDepth2(depth1);
	}
	
	@RequestMapping(value="weather/depth3", produces = "application/json;charset=utf8")
	@ResponseBody
	public List<String> selectDepth3(String depth1, String depth2, Model model) {
		return weatherService.selectDepth3(depth1, depth2);
	}
	
}
