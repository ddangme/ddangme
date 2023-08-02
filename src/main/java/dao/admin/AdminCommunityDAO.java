package dao.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.community.CommunityCategoryVO;
import vo.community.CommunityImgVO;
import vo.community.CommunityVO;
import vo.customer.CustomerVO;

public class AdminCommunityDAO {
	private SqlSession sqlSession;
	
	public AdminCommunityDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
//	커뮤니티 게시판 추가
	public int insertCategory(CommunityCategoryVO vo) {
		return sqlSession.insert("admin-community.insertCategory", vo);
	}
	
//	게시판 중복 확인
	public int checkDuplicate(CommunityCategoryVO vo) {
		return sqlSession.selectOne("admin-community.checkDuplicate", vo);
	}
	
//	커뮤니티 게시판 수정
	public int setCategory(CommunityCategoryVO vo) {
		return sqlSession.update("admin-community.setCategory", vo);
	}
	
//	게시판 삭제
	public int delCategory(int no) {
		return sqlSession.delete("admin-community.delCategory", no);
	}
	
//	커뮤니티 리스트 출력 (관리자)
	public List<CommunityVO> getCommunityList() {
		return sqlSession.selectList("admin-community.getCommunityList");
	}
	
//	커뮤니티 리스트 검색 (관리자)
	public List<CommunityVO> searchCommunity(CommunityVO vo) {
		return sqlSession.selectList("admin-community.searchCommunity", vo);
	}
	
//	커뮤니티 카테고리 조회
	public List<CommunityCategoryVO> getCommunityCategory() {
		return sqlSession.selectList("admin-community.getCommunityCategory");
	}
	
//	커뮤니티 게시물 상세 데이터 조회
	public CommunityVO getCommunity(int no) {
		return sqlSession.selectOne("admin-community.getCommunity", no);
	}
	
//	커뮤니티 게시물 이미지 조회
	public List<CommunityImgVO> getCommunityImg(int no) {
		return sqlSession.selectList("admin-community.getCommunityImg", no);
	}
	
//	커뮤니티 게시물 삭제
	public int deleteCommunity(int no) {
		return sqlSession.delete("admin-community.deleteCommunity", no);
	}
}
