package com.example.repo;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.entity.User;

public interface UserRepo extends JpaRepository<User, Integer> {
	User findByEmailAndRole(String email, String role);

	@Modifying
	@Transactional
	@Query("UPDATE User s SET s.name = :name, s.email = :email, s.phone = :phone WHERE s.id = :id")
	int updateStudentById(@Param("id") int id, @Param("name") String name, @Param("email") String email,
			@Param("phone") String phone);

	User findByEmail(String adminEmail);

	long countByRole(String role);
	List<User> findByRole(String role);
}
