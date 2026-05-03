package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.entity.Certificate;
import com.example.entity.Recommendation;
import com.example.entity.Test;
import com.example.entity.User;
import com.example.repo.CertificateRepo;
import com.example.repo.RecommendationRepo;
import com.example.repo.TestRepo;
import com.example.repo.UserRepo;

@Service
public class StudentService {

	@Autowired
	private CertificateRepo cr;
	@Autowired
	private RecommendationRepo rr;
	@Autowired
	private UserRepo ur;
	@Autowired
	private TestRepo tr;

	public void saveCertificate(Certificate c1) {
          cr.save(c1);
	}

	public int getCertificateCount(int id) {
		return cr.countByStudentId(id);
	}

	public void saveAiFeedback(Recommendation r) {
		rr.save(r);
	}

	public List<Recommendation> getAiFeedback(User student) {
		return rr.findAllByStudent(student);
	}

	public void delete(int id) {
		ur.deleteById(id);
	}

	public List<User> findByRole(String role) {
		return ur.findByRole(role);
	}

	public List<Test> findStudentByTest(int id) {
		return tr.findByStudentIdOrderByTestDateAsc(id);
	}

	public int findCount() {
		return (int) cr.count();
	}

	public double studPer(List<Test> tests) {
		int totalScore = 0;
		int totalMarks = 0;
		for (Test test : tests) {
			totalScore += test.getScore();
			totalMarks += test.getTotalQuestions();
		}
		double percentage = totalMarks == 0 ? 0 : (totalScore * 100.0 / totalMarks);
		return percentage;
	}

}
