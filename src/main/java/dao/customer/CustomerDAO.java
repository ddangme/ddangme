package dao.customer;

import org.apache.ibatis.session.SqlSession;

import vo.customer.CustomerVO;

public class CustomerDAO {
	private SqlSession sqlSession;
	
	public CustomerDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	// 회원가입
	public void joinCustomer(CustomerVO vo) {
		sqlSession.selectOne("customer.joinCustomer", vo);
	}
	
	// 로그인
	public CustomerVO login(String no) {
		return sqlSession.selectOne("customer.login", no);
	}
	
	// 마이페이지 기본 데이터 조회
	public CustomerVO selectBasicData(String no) {
		return sqlSession.selectOne("customer.selectBasicData", no);
	}
}
