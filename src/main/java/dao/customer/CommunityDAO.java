package dao.customer;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.community.CommunityCategoryVO;
import vo.community.CommunityImgVO;
import vo.community.CommunityVO;
import vo.customer.CustomerVO;

public class CommunityDAO {
	private SqlSession sqlSession;
	
	public CommunityDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
//	커뮤니티 게시판 추가
	public int insertCategory(CommunityCategoryVO vo) {
		return sqlSession.insert("community.insertCategory", vo);
	}
	
//	커뮤니티 게시물 번호
	public int getCommunityNo() {
		return sqlSession.selectOne("community.getCommunityNo");
	}
	
//	커뮤니티 게시물 작성
	public int communityWrite(CommunityVO vo) {
		return sqlSession.insert("community.communityWrite", vo);
	}
	
//	커뮤니티 게시물 작성 (이미지)
	public int communityImgWrite(CommunityImgVO vo) {
		return sqlSession.insert("community.communityImgWrite", vo);
	}
	
//	커뮤니티 게시물 작성 (카테고리 테이블 카운트)
	public int setCommunityCategoryCount(int category_no) {
		return sqlSession.update("community.setCommunityCategoryCount", category_no);
	}
	
//	커뮤니티 리스트 출력
	public List<CommunityVO> communityList(int no) {
		return sqlSession.selectList("community.communityList", no);
	}
	
//	커뮤니티 리스트 출력 (관리자)
	public List<CommunityVO> getCommunityList() {
		return sqlSession.selectList("community.getCommunityList");
	}
	
//	커뮤니티 리스트 검색 (관리자)
	public List<CommunityVO> searchCommunity(CommunityVO vo) {
		return sqlSession.selectList("community.searchCommunity", vo);
	}
	
//	커뮤니티 카테고리 조회
	public List<CommunityCategoryVO> getCommunityCategory() {
		return sqlSession.selectList("community.getCommunityCategory");
	}
	
//	커뮤니티 게시물 상세 데이터 조회
	public CommunityVO getCommunity(int no) {
		return sqlSession.selectOne("community.getCommunity", no);
	}
	
//	커뮤니티 게시물 이미지 조회
	public List<CommunityImgVO> getCommunityImg(int no) {
		return sqlSession.selectList("community.getCommunityImg", no);
	}
	
//	커뮤니티 게시물 조회수 증가
	public void setCommunityHit(int no) {
		sqlSession.selectOne("community.setCommunityHit", no);
	}
	
//	커뮤니티 게시물 작성자 정보
	public CustomerVO getCommunityWriter(int no) {
		return sqlSession.selectOne("community.getCommunityWriter", no);
	}
	
//	커뮤니티 게시물 삭제
	public int deleteCommunity(int no) {
		return sqlSession.delete("community.deleteCommunity", no);
	}
}
