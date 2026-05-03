package com.example.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.entity.Course;

@Repository
public interface CourseRepo extends JpaRepository<Course, Long>{

}
