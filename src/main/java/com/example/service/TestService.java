package com.example.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.example.entity.SubjectStats;
import com.example.entity.Test;
import com.example.repo.TestRepo;

@Service
public class TestService {

	@Autowired
	private TestRepo tr;

	public void save(Test test) {
		tr.save(test);
	}

	public Test findById(Long testId) {
		return tr.getById(testId);
	}

	public List<Test> getTestsByStudent(int i) {

		return tr.findByStudentIdOrderByTestDateAsc(i);
	}

	public int getTestsCount(int id) {
		return tr.countByStudentId(id);
	}

	public long testCount() {
		return tr.count();
	}

	public Object getTop3Students(Pageable pageable) {
		return tr.findTopStudents(pageable);
	}

	public List<Map<String, Object>> countTestPerDay() {
		List<Object[]> list = tr.countTestsPerDay();

		List<Map<String, Object>> result = new ArrayList<>();

		for (Object[] obj : list) {
			Map<String, Object> map = new HashMap<>();
			map.put("date", obj[0].toString()); // YYYY-MM-DD
			map.put("count", obj[1]);
			result.add(map);
		}
		return result;
	}

	public List<Test> getAllTests() {
		return tr.findAll();
	}

	public Map<String, Integer> getScoreDistribution(List<Test> tests1) {
		int r1 = 0, r2 = 0, r3 = 0, r4 = 0;

		for (Test test : tests1) {

			if (test.getTotalQuestions() == 0)
				continue;

			double per = (test.getScore() * 100.0) / test.getTotalQuestions();

			if (per < 40) {
				r1++;
			} else if (per < 60) {
				r2++;
			} else if (per < 80) {
				r3++;
			} else {
				r4++;
			}
		}

		Map<String, Integer> map = new HashMap<>();
		map.put("r1", r1);
		map.put("r2", r2);
		map.put("r3", r3);
		map.put("r4", r4);

		return map;
	}

	public List<SubjectStats> getSubjectStats(List<Test> tests) {

	    Map<String, Long> map = new HashMap<>();

	    for (Test t : tests) {

	        if (t.getCourse() == null) continue;

	        String subject = t.getCourse().getCourseName(); // course name

	        map.put(subject, map.getOrDefault(subject, 0L) + 1);
	    }

	    List<SubjectStats> list = new ArrayList<>();

	    for (Map.Entry<String, Long> entry : map.entrySet()) {
	        list.add(new SubjectStats(entry.getKey(), entry.getValue()));
	    }

	    return list;
	}
}
