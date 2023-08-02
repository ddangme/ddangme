package service.admin;

import dao.admin.AdminDAO;
import vo.admin.AdminVO;

public class AdminService {
	private AdminDAO adminDao;
	
	public AdminService(AdminDAO adminDao) {
		this.adminDao = adminDao;
	}
	
	public boolean login(AdminVO vo) {
		if (adminDao.login(vo) != 0) {
			return true;
		}
		return false;
	}
}
