package service.weather;

import java.util.List;

import dao.weather.WeatherDAO;
import vo.weather.AdminAddressDataVO;

public class WeatherService {
	private WeatherDAO weatherDao;
	
	public WeatherService(WeatherDAO weatherDao) {
		this.weatherDao = weatherDao;
	}
	
	public List<String> selectDepth1() {
		return weatherDao.selectDepth1();
	}
	
	public List<String> selectDepth2(String depth1) {
		return weatherDao.selectDepth2(depth1);
	}
	
	public List<String> selectDepth3(String depth1, String depth2) {
		AdminAddressDataVO vo = new AdminAddressDataVO();
		vo.setDepth1(depth1);
		vo.setDepth2(depth2);
		return weatherDao.selectDepth3(vo);
	}
}
