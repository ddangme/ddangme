package dao.admin;

import org.apache.ibatis.session.SqlSession;

import vo.admin.AdminVO;

public class AdminDAO {
	private SqlSession sqlSession;
	
	public AdminDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int login(AdminVO vo) {
		return sqlSession.selectOne("admin.login", vo);
	}
}
