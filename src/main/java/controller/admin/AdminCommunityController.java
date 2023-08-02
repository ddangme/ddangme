package controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import service.admin.AdminCommunityService;
import service.admin.AdminService;
import service.customer.CommunityService;
import vo.admin.AdminVO;
import vo.community.CommunityCategoryVO;
import vo.community.CommunityImgVO;
import vo.community.CommunityVO;
import vo.customer.CustomerVO;

@Controller
public class AdminCommunityController {
	private AdminCommunityService adminCommunityService;
	private CommunityService communityService;
	
	public AdminCommunityController(AdminCommunityService adminCommunityService, CommunityService communityService) {
		this.adminCommunityService = adminCommunityService;
		this.communityService = communityService;
	}
	
//	커뮤니티 게시물 리스트 조회
	@RequestMapping("admin/community/list")
	public String communityList(Model model) {
		List<CommunityCategoryVO> categoryList = adminCommunityService.getCommunityCategory();
		List<CommunityVO> communityList = adminCommunityService.getCommunityList();
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("communityList", communityList);
		return "admin/community/list";
	}
	
//	커뮤니티 게시물 본문 조회
	@RequestMapping("admin/community/{no}")
	public String getContent(Model model, @PathVariable("no") int no) {
		CustomerVO writer = communityService.getCommunityWriter(no);
		CommunityVO vo = communityService.getCommunity(no);
		List<CommunityImgVO> imgVo = adminCommunityService.getCommunityImg(no);
		model.addAttribute("vo", vo);
		model.addAttribute("imgVo", imgVo);
		model.addAttribute("writer", writer);
		return "/customer/community/content";
	}
	
//	게시판 리스트 진입
	@RequestMapping("admin/community/category")
	public String communityCategory(Model model) {
		List<CommunityCategoryVO> categoryList = adminCommunityService.getCommunityCategory();
		model.addAttribute("categoryList", categoryList);
		return "admin/community/category";
	}
	
//	게시판 추가
	@RequestMapping("admin/community/category/insert")
	@ResponseBody
	public String insertCategory(Model model, CommunityCategoryVO vo) {
		return adminCommunityService.insertCategory(vo);
	}
	
//	게시판 수정
	@RequestMapping("admin/community/category/update")
	@ResponseBody
	public String updateCategory(Model model, CommunityCategoryVO vo) {
		return adminCommunityService.setCategory(vo);
	}
	
//	게시판 삭제
	@RequestMapping("admin/community/category/delete")
	@ResponseBody
	public String delCategory(Model model, int no) {
		return adminCommunityService.delCategory(no);
	}
	
//	게시물 삭제
	@RequestMapping("admin/community/delete")
	@ResponseBody
	public String delCommunity(Model model, String list) {
		// 댓글 삭제도 구현
		String[] delList = list.split(" ");
		if (adminCommunityService.deleteCommunity(delList))
			return "성공";
		return "";
	}
	
//	검색 동작
	@RequestMapping("admin/community/search")
	@ResponseBody
	public String search(Model model, CommunityVO vo) {
		List<CommunityVO> communityList = adminCommunityService.searchCommunity(vo);
		model.addAttribute("communityList", communityList);
		return "";
	}
	
//	공지 관리 페이지 이동
	@RequestMapping("admin/community/notice/list")
	public String noticeList(Model model) {
		return "admin/community/noticeList";
	}
	
	
//	공지 등록 페이지 이동
	@RequestMapping("admin/community/notice/writeForm")
	public String noticeWriteForm(Model model) {
		return "admin/community/notice";
	}
	
	
}
