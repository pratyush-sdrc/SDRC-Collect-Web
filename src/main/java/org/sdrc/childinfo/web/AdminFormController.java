package org.sdrc.childinfo.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.sdrc.childinfo.model.AdminLog;
import org.sdrc.childinfo.model.MonitoringFormTran;
import org.sdrc.childinfo.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//@author: Pratyush
@Controller
public class AdminFormController {

	List<MonitoringFormTran> auditList = null;

//	@ModelAttribute("auditList")
//	public List<MonitoringFormTran> auditList() {
//		if (auditList != null)
//			System.out.println("auditList current size : " + auditList.size());
//		return auditList;
//	}

	private AdminService adminService;

	@Autowired
	public AdminFormController(AdminService adminService) {
		this.adminService = adminService;
	}

	@RequestMapping(value = "/adminauditform", method = RequestMethod.POST)
	public String finddata(@ModelAttribute("adminLog") AdminLog adminLog,
			BindingResult result, RedirectAttributes redirectAttributes)
			throws Exception {
		// System.out.println("Admin form controller is called");
		// System.out.println(adminLog.getStart());
		// System.out.println(adminLog.getEnd());
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");
		Date startdate = formatter.parse(adminLog.getStart());
		Date enddate = formatter.parse(adminLog.getEnd());
		// List<Date> dates=new ArrayList<Date>();
		// dates.add(startdate);
		Map<String, Date> dateMap = new HashMap<String, Date>();
		dateMap.put("startdate", startdate);
		dateMap.put("enddate", enddate);
		redirectAttributes.addFlashAttribute("date", dateMap);
		// auditList = adminService.findRecordByDate(
		// new Timestamp(startdate.getTime()),
		// new Timestamp(enddate.getTime()));
		return "redirect:/logs";
	}

}
