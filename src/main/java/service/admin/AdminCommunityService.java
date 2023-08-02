package service.admin;

import java.util.List;

import dao.admin.AdminCommunityDAO;
import vo.community.CommunityCategoryVO;
import vo.community.CommunityImgVO;
import vo.community.CommunityVO;

public class AdminCommunityService {
	private AdminCommunityDAO adminCommunityDao;
	
	public AdminCommunityService(AdminCommunityDAO adminCommunityDao) {
		this.adminCommunityDao = adminCommunityDao;
	}
	
//	커뮤니티 게시판 추가
	public String insertCategory(CommunityCategoryVO vo) {
		vo.setNo(-1);
		if (adminCommunityDao.checkDuplicate(vo) == 0) { // name, link가 중복되지 않는다면,
			if (adminCommunityDao.insertCategory(vo) != 0)
				return "0"; // 성공
			else 
				return "1"; // 실패
		} 
		return "2"; // 중복
	}
	
//	커뮤니티 게시판 수정
	public String setCategory(CommunityCategoryVO vo) {
		if (adminCommunityDao.checkDuplicate(vo) == 0) { // name, link가 중복되지 않는다면,
			if (adminCommunityDao.setCategory(vo) != 0)
				return "0"; // 성공
			else 
				return "1"; // 실패
		} 
		return "2"; // 중복
	}
	
//	게시판 삭제
	public String delCategory(int no) {
		if (adminCommunityDao.delCategory(no) != 0)
			return "0"; // 성공
		return "1"; // 실패
	}
	
//	커뮤니티 게시물 조회 (관리자)
	public List<CommunityVO> getCommunityList() {
		return adminCommunityDao.getCommunityList();
	}
	
//	커뮤니티 게시물 검색 (관리자)
	public List<CommunityVO> searchCommunity(CommunityVO vo) {
		return adminCommunityDao.searchCommunity(vo);
	}
	
//	커뮤니티 카테고리 조회
	public List<CommunityCategoryVO> getCommunityCategory() {
		return adminCommunityDao.getCommunityCategory();
	}
	
//	커뮤니티 게시물 이미지 조회
	public List<CommunityImgVO> getCommunityImg(int no) {
		return adminCommunityDao.getCommunityImg(no);
	}
	
//	커뮤니티 게시물 삭제 (관리자)
	public boolean deleteCommunity(String[] list) {
		for (String del : list) {
			if (adminCommunityDao.deleteCommunity(Integer.parseInt(del)) != 1) {
				return false;
			}
		}
		return true;
	}
	
}
