package com.example.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.entity.Course;
import com.example.entity.SubjectStats;
import com.example.entity.Test;
import com.example.repo.CourseRepo;

@Service
public class CourseService {

	@Autowired
	private CourseRepo cr;

	public List<Course> findAll() {
		return cr.findAll();
	}

	public Course getById(Long courseId) {
		return cr.getById(courseId);
	}

	public long courseCount() {
		return cr.count();
	}

	public void save(Course c) {
		cr.save(c);
	}

	public void delete(long id) {
		cr.deleteById(id);
	}
}
