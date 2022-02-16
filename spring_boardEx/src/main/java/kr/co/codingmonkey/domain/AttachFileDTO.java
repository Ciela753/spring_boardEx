package kr.co.codingmonkey.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AttachFileDTO {
	private String fileName;
	private String uploadPath;
	private String uuid;
	private String origin;
	private String path;
	private String ext;
	private String mime;
	private Long size;
	private boolean image;
	
	public AttachFileDTO(String fullPath) {
		ext = fullPath.substring(fullPath.lastIndexOf(".")+1);
		fullPath = fullPath.replace("."+ext, "");
		path = fullPath.substring(0, fullPath.lastIndexOf("/"));
		uuid = fullPath.substring(fullPath.lastIndexOf("/")+1);
	}
	
	public String getThumb() {
		return path + "/s_" + uuid + "." + ext;
	}
	public String getFullPath() {
		return path + "/" + uuid + "." + ext;
	}
}
