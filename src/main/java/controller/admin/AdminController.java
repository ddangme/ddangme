package controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import service.admin.AdminService;
import vo.admin.AdminVO;

@Controller
public class AdminController {
	private AdminService adminService;
	
	public AdminController(AdminService adminService) {
		this.adminService = adminService;
	}
	
	@RequestMapping("admin")
	public String loginForm() {
		return "admin/login";
	}
	
	@RequestMapping(value="admin/login", produces = "application/text;charset=utf8")
	@ResponseBody
	public String login(Model model, AdminVO vo) {
		if (adminService.login(vo)) {
			return Integer.toString(vo.getNo());
		}
		return "";
	}
	
	@RequestMapping("admin/list")
	public String main() {
		return "admin/main";
	}
	
}
