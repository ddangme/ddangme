package dao.weather;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.weather.AdminAddressDataVO;

public class WeatherDAO {
	private SqlSession sqlSession;
	
	public WeatherDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<String> selectDepth1() {
		return sqlSession.selectList("address.selectDepth1");
	}
	
	public List<String> selectDepth2(String depth1) {
		return sqlSession.selectList("address.selectDepth2", depth1);
	}
	
	public List<String> selectDepth3(AdminAddressDataVO vo) {
		return sqlSession.selectList("address.selectDepth3", vo);
	}
}
