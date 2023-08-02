package vo.community;

import org.springframework.web.multipart.MultipartFile;

public class CommunityImgVO {
	private int no;
	private String image;
	private int community_no;
	
	private MultipartFile[] imageList;
	
	public CommunityImgVO() { }

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public int getCommunity_no() {
		return community_no;
	}

	public void setCommunity_no(int community_no) {
		this.community_no = community_no;
	}

	public MultipartFile[] getImageList() {
		return imageList;
	}

	public void setImageList(MultipartFile[] imageList) {
		this.imageList = imageList;
	}
	
}
