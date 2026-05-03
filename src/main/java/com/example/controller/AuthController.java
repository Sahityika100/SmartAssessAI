package com.example.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.entity.Recommendation;
import com.example.entity.Test;
import com.example.entity.User;
import com.example.jwt.JwtUtil;
import com.example.service.StudentService;
import com.example.service.TestService;
import com.example.service.UserService;

@Controller
@RequestMapping("/smartai")
public class AuthController {

	@Autowired
	private UserService service;

	@Autowired
	private JwtUtil jwtUtil;

	@Autowired
	private TestService ts;

	@Autowired
	private StudentService ss;

	@GetMapping("/")
	public String home() {
		return "index";
	}

	// REGISTER SAVE
	@PostMapping("/register")
	public String register(User user) {
		boolean isSaved = service.register(user);

	    if (isSaved) {
	    	return "redirect:/smartai/?status=registered&modal=login";
	    } else {
	    	return "redirect:/smartai/?status=register_failed&modal=signup";
	    }
	}

	// LOGIN CHECK
	@PostMapping("/login")
	public String login(@RequestParam String email, @RequestParam String password, @RequestParam String role,
			Model model, HttpSession session) {

		User user = service.login(email, password, role);

		if (user != null) {
			String token = jwtUtil.generateToken(email, role);
			session.setAttribute("token", token);
			session.setAttribute("role", user.getRole());
			session.setAttribute("name", user.getName());
			session.setAttribute("uid",user.getId());

			if (role.equalsIgnoreCase("ADMIN"))
				session.setAttribute("admin", user);
					
			if (role.equalsIgnoreCase("ADMIN")) {
				return "redirect:/admin/adb"; 
			} else {
				return "redirect:/smartai/sdb"; // student course
			}

		}  else {
			return "redirect:/smartai/?status=login_failed&modal=login";
		}
	}

	public boolean isLoggedIn(HttpSession session) {
		return session.getAttribute("token") != null;
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "index";
	}

	@GetMapping("/sdb")
	public String studentdb(HttpSession session, Model model) {

		if (isLoggedIn(session)) {
			int uid = (int) session.getAttribute("uid");
			User user = service.getUserById(uid);
			List<Test> tests = ts.getTestsByStudent(user.getId());
			int tcount = ts.getTestsCount(user.getId());
			int ccount = ss.getCertificateCount(user.getId());
			List<Integer> scores = new ArrayList<>();
			List<String> dates = new ArrayList<>();

			int totalObtained = 0;
			int totalMarks = 0;
			for (Test t : tests) {
				totalObtained += t.getScore();
				totalMarks += t.getTotalQuestions();
				scores.add((int) Math.round((double) t.getScore() / t.getTotalQuestions() * 100));
				dates.add(t.getTestDate().toLocalDate().toString());
			}

			double avgscore = 0;
			if (totalMarks != 0) {
				avgscore = Math.round((double) totalObtained / totalMarks * 100);
			}

			model.addAttribute("scores", scores);
			model.addAttribute("avgscore", avgscore);
			model.addAttribute("dates", dates);
			model.addAttribute("hasData", !tests.isEmpty());
			model.addAttribute("tcount", tcount);
			model.addAttribute("ccount", ccount);
			return "sdb";
		} else {
			return "redirect:/smartai/";
		}
	}

	@GetMapping("/profile")
	public String getProfile(HttpSession session, Model model) {
		if (!isLoggedIn(session))
			return "redirect:/smartai/";

		int uid = (int) session.getAttribute("uid");
		User student = service.getUserById(uid);
		model.addAttribute("student", student);
		return "profile";
	}

	@PostMapping("/update")
	public String updateProfile(@RequestParam String name, @RequestParam String email, @RequestParam String phone,
			@RequestParam int id, HttpSession session,Model model) {
		service.updateById(id, name, email, phone);

		return "redirect:/smartai/profile";
	}
	
	@GetMapping("/recommendations")
	public String aiFeedback(HttpSession session,Model model) {
		if (!isLoggedIn(session))
			return "redirect:/smartai/";

		int uid = (int) session.getAttribute("uid");
		User student = service.getUserById(uid);
		List<Recommendation> ar = ss.getAiFeedback(student);
		model.addAttribute("feedback", ar);
		return "aifeedback";
	}
	
	@PostMapping("/delete")
	public String delete(@RequestParam int id,HttpSession session) {
		ss.delete(id);
		session.invalidate();
		return "redirect:/smartai/";
	}
}