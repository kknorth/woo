package com.fairmusic.dto;

public class followDTO {
	String artist_code;
	String artist_follow_code;
	String follow_good_alive;
	
	public followDTO(){}
	
	public followDTO(String artist_code, String artist_follow_code,
			String follow_good_alive) {
		super();
		this.artist_code = artist_code;
		this.artist_follow_code = artist_follow_code;
		this.follow_good_alive = follow_good_alive;
	}

	public String getArtist_code() {
		return artist_code;
	}

	public void setArtist_code(String artist_code) {
		this.artist_code = artist_code;
	}

	public String getArtist_follow_code() {
		return artist_follow_code;
	}

	public void setArtist_follow_code(String artist_follow_code) {
		this.artist_follow_code = artist_follow_code;
	}

	public 	String getFollow_good_alive() {
		return follow_good_alive;
	}

	public void setFollow_good_alive(	String follow_good_alive) {
		this.follow_good_alive = follow_good_alive;
	}

	@Override
	public String toString() {
		return "followDTO [artist_code=" + artist_code
				+ ", artist_follow_code=" + artist_follow_code
				+ ", follow_good_alive=" + follow_good_alive + "]";
	}
	
	
}
