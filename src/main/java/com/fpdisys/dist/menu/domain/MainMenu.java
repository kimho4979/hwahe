package com.fpdisys.dist.menu.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import lombok.Getter;
import lombok.Setter;

import com.fpdisys.base.mvc.BaseVo;
import com.fasterxml.jackson.annotation.JsonProperty;

@Setter
@Getter
public class MainMenu  extends BaseVo {

		@JsonProperty("_id")
		private String id;

		@JsonProperty("label")
		private String label;

		@JsonProperty("icon")
		private String icon;

		@JsonProperty("url")
		private String url = "#";

		@JsonProperty("target")
		private String target = "_self";
		
		@JsonProperty("parentId")
		private String parentId;
		
		@JsonProperty("cn")
		private List<MainMenu> child = new ArrayList<>();
		
		private final static String ICON_CSS_STYLE = "<i class='axi %s'></i> ";
		public MainMenu(AuthorizedMenu authorizedMenu) {
			this.id = authorizedMenu.getMenuCode();
			this.label = authorizedMenu.getMenuName();
			this.icon = authorizedMenu.getIcon();
			this.parentId = authorizedMenu.getParentMenuCode();

			if(StringUtils.isEmpty(icon) == false) {
				this.label = String.format(ICON_CSS_STYLE, icon) + this.label;
			}

			if(StringUtils.isEmpty(authorizedMenu.getProgramPath()) == false) {
				this.url = authorizedMenu.getProgramPath();
				this.target = authorizedMenu.getTarget();
				this.url = authorizedMenu.getProgramPath();
			}
		}

		public void addChild(AuthorizedMenu authorizedMenu) {
			child.add(new MainMenu(authorizedMenu));
		}
	}

