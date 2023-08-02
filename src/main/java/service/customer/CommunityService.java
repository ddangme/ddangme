package service.customer;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import dao.customer.CommunityDAO;
import vo.community.CommunityCategoryVO;
import vo.community.CommunityImgVO;
import vo.community.CommunityVO;
import vo.customer.CustomerVO;

public class CommunityService {
	private CommunityDAO communityDao;
	
	public CommunityService(CommunityDAO communityDao) {
		this.communityDao = communityDao;
	}
	
//	커뮤니티 게시판 추가
	public boolean insertCommunity(CommunityCategoryVO vo) {
		if (communityDao.insertCategory(vo) == 0)
			return false;
		return true;
	}
	
//	커뮤니티 게시물 번호
	public int getCommunityNo() {
		return communityDao.getCommunityNo();
	}
	
//	커뮤니티 게시물 작성
	public boolean communityWrite(String savePath, CommunityVO cVo, CommunityImgVO ciVo, int customerNo) {
		int communityNo = communityDao.getCommunityNo();

		cVo.setNo(communityNo);
		cVo.setCustomer_no(customerNo);
		if (communityDao.communityWrite(cVo) == 0) {
			return false;
		} else {
			if (communityDao.setCommunityCategoryCount(cVo.getCategory_no()) == 0) {
				return false;
			}
			if (!ciVo.getImageList()[0].getOriginalFilename().isEmpty()) {
				for (MultipartFile file : ciVo.getImageList()) {
					CommunityImgVO vo = new CommunityImgVO();
					vo.setCommunity_no(communityNo);
					String filename = file.getOriginalFilename();
					File saveFile = new File(savePath + communityNo, filename);
					if (!saveFile.exists()) {
						vo.setImage(filename);
						saveFile.mkdirs();
					} else {
						int i = 1;
						while (saveFile.exists()) {
							filename = String.format("%s%s%s", filename.substring(0, filename.lastIndexOf(".")), "(" + i + ")" ,filename.substring(filename.lastIndexOf(".")));
							i++;
						}
						vo.setImage(filename);
						saveFile = new File(savePath + communityNo, filename);
					}
					try {
						file.transferTo(saveFile);
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
					if (communityDao.communityImgWrite(vo) == 0) {
						return false;
					}
				}
			}
		}
		return true;
	}
	
//	커뮤니티 게시물 출력 
	public List<CommunityVO> communityList(String link, List<CommunityCategoryVO> categoryList) {
		int no = -1;
		for (CommunityCategoryVO vo : categoryList) {
			if (vo.getLink().equals(link)) {
				no = vo.getNo();
				break;
			}
		}
		
		List<CommunityVO> list = communityDao.communityList(no);
		
		if (list.isEmpty()) return null;
		return list;
	}
	
//	커뮤니티 게시물 조회 (관리자)
	public List<CommunityVO> getCommunityList() {
		return communityDao.getCommunityList();
	}
	
//	커뮤니티 게시물 검색 (관리자)
	public List<CommunityVO> searchCommunity(CommunityVO vo) {
		return communityDao.searchCommunity(vo);
	}
	
//	커뮤니티 카테고리 조회
	public List<CommunityCategoryVO> getCommunityCategory() {
		return communityDao.getCommunityCategory();
	}
	
//	커뮤니티 게시물 상세 데이터 조회 및 조회수 증가
	public CommunityVO getCommunity(int no) {
		communityDao.setCommunityHit(no);
		return communityDao.getCommunity(no);
	}
	
//	커뮤니티 게시물 이미지 조회
	public List<CommunityImgVO> getCommunityImg(int no) {
		return communityDao.getCommunityImg(no);
	}
	
//	커뮤니티 게시물 작성자 정보 조회
	public CustomerVO getCommunityWriter(int no) {
		return communityDao.getCommunityWriter(no);
	}
	
//	커뮤니티 게시물 삭제
	public int deleteCommunity(int no) {
		return communityDao.deleteCommunity(no);
	}
	
//	커뮤니티 게시물 삭제 (관리자)
	public boolean deleteCommunity(String[] list) {
		for (String del : list) {
			if (communityDao.deleteCommunity(Integer.parseInt(del)) != 1) {
				return false;
			}
		}
		return true;
	}
	
}
