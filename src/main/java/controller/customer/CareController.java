package controller.customer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import service.customer.CustomerService;
import vo.customer.CustomerVO;

@Controller
public class CareController {
	
	private CustomerService customerService;
	
	public CareController(CustomerService customerService) {
		this.customerService = customerService;
	}
	
	@RequestMapping("customer/loginform")
	public String loginform() {
		return "/customer/care/login";
	}
	
	@RequestMapping("customer/login")
	public String kakaoLogin() {
		return "/customer/care/login";
	}
	
	@RequestMapping("customer/kakaoLogin")
	public String kakaoLoginInsert(HttpServletRequest request, String no, String age_group, String gender, String email, String profile, String name) {
		CustomerVO login = customerService.login(no);
		if (login == null) {
			customerService.joinCustomer(0, age_group, gender, email, profile, name, no);
			login = customerService.login(no);
			login.setProfile(profile);
		} 
		
		request.getSession().setAttribute("login", login);
		
		return "redirect:/";
	}
	
	@RequestMapping("customer/naverLoginForm")
	public String kakaoLoginInsert() {
		
		return "/customer/care/naverLogin";
	}
	
	
	@RequestMapping("customer/naverLogin")
	public String kakaoLogin(HttpServletRequest request, String no, String age_group, String gender, String email, String profile, String name) {
		CustomerVO login = customerService.login(no);
		if (login == null) {
			customerService.joinCustomer(1, age_group, gender, email, profile, name, no);
			login = customerService.login(no);
			login.setProfile(profile);
		}

		request.getSession().setAttribute("login", login);

		return "redirect:/";
	}
	
	// 로그아웃
	@RequestMapping("customer/logout")
	public String logout(HttpSession session, Model model, HttpServletRequest request) {
		session.invalidate();
		
		model.addAttribute("message", "로그아웃 되었습니다.");
		model.addAttribute("url", request.getHeader("Referer"));
		
		return "/alert";
	}
	
	// 마이페이지 진입
	@RequestMapping("customer/myPage")
	public String myPage(HttpSession session, Model model) {
		CustomerVO vo = (CustomerVO) session.getAttribute("login");
		if (vo == null) {
			model.addAttribute("message", "로그인 후 진입해 주세요.");
			model.addAttribute("url", "/ww");
			return "/alert";
		}
		model.addAttribute("vo", customerService.selectBasicData(vo.getUnique_id()));
		return "/customer/care/myPage";
	}
}
