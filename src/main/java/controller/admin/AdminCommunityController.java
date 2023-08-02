package controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import service.admin.AdminService;
import service.customer.CommunityService;
import vo.admin.AdminVO;
import vo.community.CommunityCategoryVO;
import vo.community.CommunityImgVO;
import vo.community.CommunityVO;
import vo.customer.CustomerVO;

@Controller
public class AdminCommunityController {
	private AdminService adminService;
	private CommunityService communityService;
	
	public AdminCommunityController(AdminService adminService, CommunityService communityService) {
		this.adminService = adminService;
		this.communityService = communityService;
	}
	
//	커뮤니티 게시물 리스트 조회
	@RequestMapping("admin/community/list")
	public String communityList(Model model) {
		List<CommunityCategoryVO> categoryList = communityService.getCommunityCategory();
		List<CommunityVO> communityList = communityService.getCommunityList();
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("communityList", communityList);
		return "admin/community/list";
	}
	
//	커뮤니티 게시물 본문 조회
	@RequestMapping("admin/community/{no}")
	public String getContent(Model model, @PathVariable("no") int no) {
		CustomerVO writer = communityService.getCommunityWriter(no);
		CommunityVO vo = communityService.getCommunity(no);
		List<CommunityImgVO> imgVo = communityService.getCommunityImg(no);
		model.addAttribute("vo", vo);
		model.addAttribute("imgVo", imgVo);
		model.addAttribute("writer", writer);
		return "/customer/community/content";
	}
	
	@RequestMapping("admin/community/category")
	public String communityCategory(Model model) {
		List<CommunityCategoryVO> categoryList = communityService.getCommunityCategory();
		model.addAttribute("categoryList", categoryList);
		return "admin/community/category";
	}
	
	@RequestMapping("admin/community/category/insert")
	@ResponseBody
	public String insertCommunityCategory(Model model, CommunityCategoryVO vo) {
		if (communityService.insertCommunity(vo)) {
			return "성공";
		} else {
			return "";
		}
	}
	
	@RequestMapping("admin/community/delete")
	@ResponseBody
	public String delCommunity(Model model, String list) {
		// 댓글 삭제도 구현
		String[] delList = list.split(" ");
		if (communityService.deleteCommunity(delList))
			return "성공";
		return "";
	}
	
	@RequestMapping("admin/community/search")
	@ResponseBody
	public String search(Model model, CommunityVO vo) {
		List<CommunityVO> communityList = communityService.searchCommunity(vo);
		model.addAttribute("communityList", communityList);
		return "";
	}
	
}
