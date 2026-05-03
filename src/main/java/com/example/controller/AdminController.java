package com.example.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.entity.Course;
import com.example.entity.StudentReport;
import com.example.entity.SubjectStats;
import com.example.entity.Test;
import com.example.entity.User;
import com.example.service.CourseService;
import com.example.service.StudentAnswerService;
import com.example.service.StudentService;
import com.example.service.TestService;
import com.example.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private UserService us;
	@Autowired
	private CourseService cs;
	@Autowired
	private TestService ts;
	@Autowired
	private StudentAnswerService sas;
	@Autowired
	private StudentService ss;

	@GetMapping("/adb")
	public String adminDb(HttpSession session, Model m) {
		long ns = us.countByRole("student");
		long nc = cs.courseCount();
		long nt = ts.testCount();
		Double accuracy = sas.getOverallAccuracy();
		m.addAttribute("nostuds", ns);
		m.addAttribute("nocourses", nc);
		m.addAttribute("notest", nt);
		m.addAttribute("accuracy", accuracy);
		Pageable pageable = PageRequest.of(0, 3);
		m.addAttribute("topStudents", ts.getTop3Students(pageable));
		m.addAttribute("testPerDay", ts.countTestPerDay());
		return "adb";
	}

	@GetMapping("/addCourses")
	public String addCourses(Model m) {
		List<Course> courses = cs.findAll();
		m.addAttribute("courses", courses);
		return "addcourse";
	}

	@PostMapping("/saveCourse")
	public String saveCourse(@ModelAttribute Course c) {
		cs.save(c);
		return "redirect:/admin/addCourses";
	}

	@GetMapping("/delCourse/{id}")
	public String delCourse(@PathVariable long id) {
		cs.delete(id);
		return "redirect:/admin/addCourses";
	}

	@GetMapping("/manageStud")
	public String manageStud(Model m) {
		List<User> students = ss.findByRole("student");
		List<StudentReport> srl = new ArrayList<StudentReport>();
		for (User user : students) {
			List<Test> tests = ss.findStudentByTest(user.getId());
			double percentage = ss.studPer(tests);
			StudentReport sr = new StudentReport();
			sr.setId(user.getId());
			sr.setName(user.getName());
			sr.setEmail(user.getEmail());
			sr.setPhone(user.getPhone());
			sr.setNtest(tests.size());
			sr.setPercentage(percentage);
			sr.setRole(user.getRole());
			srl.add(sr);
		}
		m.addAttribute("students", srl);
		return "managestud";
	}

	@GetMapping("/analytics")
	public String analytics(Model m) {

	    List<User> students = ss.findByRole("student");

	    long nt = ts.testCount();
	    Double accuracy = sas.getOverallAccuracy();
	    int certificateCount = ss.findCount();

	    int passCount = 0;
        int failCount = 0;
	    for (User user : students) {
	        List<Test> tests = ss.findStudentByTest(user.getId());
	        double per = ss.studPer(tests);

	        if (per >= 40.0) {
	            passCount++;
	        }
	        else {
	        	failCount++;
	        }
	    }

	    double passPer = 0;
	    if (students.size() != 0) {
	        passPer = (passCount * 100.0) / students.size();
	        passPer = Double.parseDouble(String.format("%.2f", passPer));
	    }

	    List<Test> tests1 = ts.getAllTests();
	    Map<String, Integer> dist = ts.getScoreDistribution(tests1);
	    List<SubjectStats> subjects = ts.getSubjectStats(tests1);
	    m.addAttribute("subjects", subjects);
	    m.addAttribute("passRate", passPer);
	    m.addAttribute("notest", nt);
	    m.addAttribute("accuracy", accuracy);
	    m.addAttribute("certCount", certificateCount);
	    m.addAttribute("r1", dist.get("r1"));
	    m.addAttribute("r2", dist.get("r2"));
	    m.addAttribute("r3", dist.get("r3"));
	    m.addAttribute("r4", dist.get("r4"));
	    m.addAttribute("passCount",passCount);
	    m.addAttribute("failCount",failCount);
	    
	    return "analytics";
	}
}
