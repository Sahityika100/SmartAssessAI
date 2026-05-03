package com.example.repo;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.entity.Test;

@Repository
public interface TestRepo extends JpaRepository<Test, Long> {
	List<Test> findByStudentIdOrderByTestDateAsc(int i);
	int countByStudentId(int studentId);
	
	@Query("SELECT u.name as name, AVG((t.score * 100.0) / t.totalQuestions) as percentage " +
		       "FROM Test t JOIN t.student u " +
		       "GROUP BY u.id, u.name " +
		       "ORDER BY percentage DESC")
		List<Object[]> findTopStudents(Pageable pageable);
	
	@Query("SELECT FUNCTION('DATE', t.testDate), COUNT(t) FROM Test t GROUP BY FUNCTION('DATE', t.testDate)")
	List<Object[]> countTestsPerDay();
}
