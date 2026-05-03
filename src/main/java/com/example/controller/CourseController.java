package com.example.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.entity.Course;
import com.example.service.CourseService;

@Controller
@RequestMapping("/courses")
public class CourseController {

	@Autowired
	private CourseService cs;
	
	@GetMapping("/getCourses")
	public String findCourses(Model m, HttpSession session) {
		if (!isLoggedIn(session))
			return "redirect:/smartai/";
		List<Course> courses = cs.findAll();
		m.addAttribute("courses", courses);
		return "course";
	}

	@GetMapping("/enroll/{id}/{name}")
	public String enroll(@PathVariable Long id, @PathVariable String name, Model m, HttpSession session) {
		if (!isLoggedIn(session))
			return "redirect:/smartai/";
		m.addAttribute("id", id);
		m.addAttribute("name", name);
		return "select-qs";

	}

	public boolean isLoggedIn(HttpSession session) {
		return session.getAttribute("token") != null;
	}
	
}
