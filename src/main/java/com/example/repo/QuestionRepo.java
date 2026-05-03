package com.example.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.entity.Question;
import com.example.entity.Test;

@Repository
public interface QuestionRepo extends JpaRepository<Question, Long> {
	List<Question> findByTest(Test test);
}
