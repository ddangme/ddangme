package controller.customer;


import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import service.customer.CommunityService;
import vo.community.CommunityCategoryVO;
import vo.community.CommunityImgVO;
import vo.community.CommunityVO;
import vo.customer.CustomerVO;

@Controller
public class CommunityController {
	
	private CommunityService communityService;

	@Autowired
	private ServletContext application;
	
	public CommunityController(CommunityService communityService) {
		this.communityService = communityService;
	}
	
	@RequestMapping({"community/category/{category}", "community"})
	public String communityMain(@PathVariable(value="category", required=false) String category, Model model, HttpServletRequest request) {
		List<CommunityCategoryVO> categoryList = communityService.getCommunityCategory();
		List<CommunityVO> list = communityService.communityList(category, categoryList);
		model.addAttribute("list", list);
		model.addAttribute("categoryList", categoryList);
		return "/customer/community/community";
	}
	
	@RequestMapping("community/writeForm")
	public String communityWriteForm(HttpSession session, Model model, HttpServletRequest request) {
		if (session.getAttribute("login") == null) {
			model.addAttribute("message", "로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?");
			model.addAttribute("url", "/ww/customer/loginform");
			return "/confirm";
		}
		List<CommunityCategoryVO> categoryList = communityService.getCommunityCategory();
		model.addAttribute("categoryList", categoryList);
		
		return "/customer/community/write";
	}
	
	@RequestMapping("community/write")
	public String communityWrite(HttpSession session, CommunityVO cVo, CommunityImgVO ciVo, Model model, HttpServletRequest request) {
		CustomerVO customerVo = (CustomerVO) session.getAttribute("login");
		if (customerVo == null) {
			model.addAttribute("message", "로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?");
			model.addAttribute("url", "/ww/customer/loginform");
			return "/confirm";
		}
		String savePath = request.getSession().getServletContext().getRealPath("/resources/community/");
		if (!communityService.communityWrite(savePath, cVo, ciVo, customerVo.getNo())) {
			model.addAttribute("message", "등록에 성공하였습니다.");
			model.addAttribute("url", "/ww/community/");
			return "/alert";
		}
		
		model.addAttribute("message", "등록에 실패하였습니다. 다시 시도해주세요.");
		model.addAttribute("url", request.getHeader("Referer"));
		return "/alert";
	}
		
	
	@RequestMapping("community/{no}")
	public String communityContent(HttpSession session, @PathVariable("no") int no, Model model, HttpServletRequest request) {
		List<CommunityCategoryVO> categoryList = communityService.getCommunityCategory();
		model.addAttribute("categoryList", categoryList);
		
		CommunityVO vo = communityService.getCommunity(no);
		List<CommunityImgVO> imgVo = communityService.getCommunityImg(no);
		if (vo == null || vo.getStatus().equals("N")) {
			model.addAttribute("message", "존재하지 않는 게시물 입니다.");
			model.addAttribute("url", "/ww/community");
			return "/alert";
		}
		if (vo.getShow_group().equals("M") && session.getAttribute("login") == null) {
			model.addAttribute("message", "회원만 조회 가능한 게시물입니다. 로그인 페이지로 이동하시겠습니까?");
			model.addAttribute("url", "/ww/customer/loginform");
			return "/confirm";
		}
		CustomerVO writer = communityService.getCommunityWriter(no);
		model.addAttribute("vo", vo);
		model.addAttribute("imgVo", imgVo);
		model.addAttribute("writer", writer);
		return "/customer/community/content";
	}
	

	@RequestMapping("community/delete/{no}")
	public String communityDelete(@PathVariable("no") int no, Model model) {
		// 해당 게시물에 작성된 댓글 모두 삭제 후 진행
		
		if (communityService.deleteCommunity(no) != 1) {
			model.addAttribute("message", "삭제에 실패하였습니다. 다시 시도해 주세요.");
			model.addAttribute("url", "/ww/community");
			
			return "/alert";
		}
		model.addAttribute("message", "삭제 되었습니다.");
		model.addAttribute("url", "/ww/community");
		return "alert";
	}
	
	@RequestMapping("community/updateForm/{no}")
	public String communityUpdateForm(HttpSession session, @PathVariable("no") int no, Model model) {
		List<CommunityCategoryVO> categoryList = communityService.getCommunityCategory();
		model.addAttribute("categoryList", categoryList);
		CommunityVO vo = communityService.getCommunity(no);
		model.addAttribute("vo", vo);
		
		return "/customer/community/update";
	}
	
	@RequestMapping("community/update/{no}")
	public String communityUpdate(HttpSession session, @PathVariable("no") int no) {
		
		return "";
	}
	
	
}
