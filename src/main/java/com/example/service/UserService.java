package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.entity.User;
import com.example.repo.UserRepo;

@Service
public class UserService {

	@Autowired
	private UserRepo repo;

	private BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

	// REGISTER
	public boolean register(User user) {
		user.setPassword(encoder.encode(user.getPassword())); // encrypt
		repo.save(user);
		return true;
	}

	// LOGIN
	public User login(String email, String password, String role) {
		User user = repo.findByEmailAndRole(email, role);

		if (user != null && encoder.matches(password, user.getPassword())) {
			return user;
		}
		return null;
	}

	public void updateById(int id, String name, String email, String phone) {
		repo.updateStudentById(id, name, email, phone);
	}

	public User getUserById(int id) {
		return repo.getById(id);
	}

	public User findByEmail(String adminEmail) {
		return repo.findByEmail(adminEmail);
	}

	public long countByRole(String role) {
		return repo.countByRole(role);
	}

}