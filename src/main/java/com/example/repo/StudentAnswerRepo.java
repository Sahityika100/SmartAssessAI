package com.example.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.entity.StudentAnswer;

@Repository
public interface StudentAnswerRepo extends JpaRepository<StudentAnswer, Long> {

	@Query(value = """
			SELECT 
			(SUM(CASE WHEN sa.selected_answer = q.correct_answer THEN 1 ELSE 0 END) * 100.0) 
			/ COUNT(*) 
			FROM student_answers sa
			JOIN questions q ON sa.question_id = q.id
			""", nativeQuery = true)
	Double getOverallAccuracy();

}

