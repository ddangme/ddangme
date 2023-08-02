package service.customer;

import dao.customer.CustomerDAO;
import vo.customer.CustomerVO;

public class CustomerService {
	private CustomerDAO customerDao;
	
	public CustomerService(CustomerDAO customerDao) {
		this.customerDao = customerDao;
	}
	
	public void joinCustomer(int kind, String age_group, String gender, String email, String profile, String name, String no) {
		CustomerVO vo = new CustomerVO();
		vo.setKind(kind);
		if (!age_group.isEmpty()) {
			int age = Character.getNumericValue(age_group.charAt(0));
			
			vo.setAge_group(age);
		}
		if (!gender.isEmpty()) {
			if (gender.contains("F") || gender.contains("f")) {
				gender = "F";
			} else {
				gender = "M";
			}
			vo.setGender(gender);
		}
		if (!email.isEmpty()) {
			vo.setEmail(email);
		}
		if (!profile.isEmpty()) {
			vo.setProfile(profile);
		}
		if (!name.isEmpty()) {
			vo.setName(name);
		}
		if (!no.isEmpty()) {
			vo.setUnique_id(no);
		}
		customerDao.joinCustomer(vo);
	}
	
	public CustomerVO login(String no) {
		return customerDao.login(no);
	}
	
	public CustomerVO selectBasicData(String no) {
		return customerDao.selectBasicData(no);
	}

	
}
