package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.entity.Question;
import com.example.entity.StudentAnswer;
import com.example.repo.StudentAnswerRepo;

@Service
public class StudentAnswerService {

	@Autowired
	private StudentAnswerRepo sar;

	public void save(String selectedAnswer, Question q) {
		StudentAnswer sa = new StudentAnswer();
		sa.setSelectedAnswer(selectedAnswer);
		sa.setQuestion(q);
		sar.save(sa);
	}

	public Double getOverallAccuracy() {
		  Double acc = sar.getOverallAccuracy();
		  return acc != null ? acc : 0.0;
	}

}
