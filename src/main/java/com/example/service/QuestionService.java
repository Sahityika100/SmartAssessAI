package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.entity.Question;
import com.example.entity.Test;
import com.example.repo.QuestionRepo;

@Service
public class QuestionService {

	@Autowired
	private QuestionRepo qr; 
	
	public List<Question> findByTest(Test test) {
		return qr.findByTest(test);
	}

}
