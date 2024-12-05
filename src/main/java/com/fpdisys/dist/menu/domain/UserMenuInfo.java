package com.fpdisys.dist.menu.domain;

import java.util.List;
import java.util.Map;

import lombok.Data;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@RequiredArgsConstructor(staticName = "of")
public class UserMenuInfo {


	@NonNull
	private Map<String, AuthorizedMenu> authorizedMenuMap;

	@NonNull
	private List<MainMenu> mainMenuList;

	@NonNull
	private String mainMenuJson;

	@NonNull
	private String mainMenuJsonHash;

}

