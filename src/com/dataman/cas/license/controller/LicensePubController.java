package com.dataman.cas.license.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.nci.license.license.License;
import org.nci.license.license.RSALicenseChecker;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.dataman.cas.web.flow.utils.PropertiesUtils;


public class LicensePubController extends MultiActionController{
	
	private  License license = null;
	
	
	public ModelAndView getMaxUserCount(HttpServletRequest request,HttpServletResponse response){
		if(license == null){
			try {
				parseLicense(request,response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		try {
			response.getWriter().print(license.getMaxUserCount());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	public ModelAndView getEndTime(HttpServletRequest request,HttpServletResponse response){
		if(license == null){
			boolean val = false;
			try {
				val = parseLicense(request,response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(!val){
				return null;
			}
		}
		try {
			response.getWriter().print(license.getEndTime());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	public ModelAndView getLicense(HttpServletRequest request,HttpServletResponse response){
		if(license == null){
			try {
				parseLicense(request,response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return null;
			}
		}
		Long endTime = license.getEndTime();
		Integer maxUserCount = license.getMaxUserCount();
		try {
			
			response.getWriter().print("endTime:"+endTime+",maxUserCount:"+maxUserCount);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	private boolean parseLicense(HttpServletRequest request,HttpServletResponse response) throws Exception{
		boolean sus = true;
		String pubKeyPath = PropertiesUtils.getLicenseConfig("pubKeyPath");
		String licensePath = PropertiesUtils.getLicenseConfig("licensePath");
		String projectPath = request.getRealPath("/");
		File pub = new File(projectPath + pubKeyPath);
		File lcs = new File(projectPath + licensePath);
		if (pub.exists() && lcs.exists()) {
			//RSALicenseChecker checker = new RSALicenseChecker(pub, lcs);
			RSALicenseChecker checker = new RSALicenseChecker(pub, lcs);
			if(license == null){
				try {
					license = checker.decryptLicenseByPubKey();
				} catch (Exception e) {
					sus = false;
					logger.error("License解析失败");
					response.getWriter().print(-1);
					e.printStackTrace();
				}
			}
		}else{
			sus = false;
			logger.error("读取License失败");
			response.getWriter().print(-2);
		}
		return sus;
	}
}
