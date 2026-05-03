package com.example.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.entity.Certificate;

@Repository
public interface CertificateRepo extends JpaRepository<Certificate, Long> {
	int countByStudentId(int studentId);
}