package com.example.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.entity.Recommendation;
import com.example.entity.User;

@Repository
public interface RecommendationRepo extends JpaRepository<Recommendation, Long>{

	List<Recommendation> findAllByStudent(User student);
}
