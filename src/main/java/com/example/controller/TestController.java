package com.example.controller;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.entity.Certificate;
import com.example.entity.Course;
import com.example.entity.Question;
import com.example.entity.Recommendation;
import com.example.entity.Test;
import com.example.entity.User;
import com.example.service.CertificateGenerator;
import com.example.service.CourseService;
import com.example.service.QuestionService;
import com.example.service.StudentAnswerService;
import com.example.service.StudentService;
import com.example.service.TestService;
import com.example.service.UserService;
import com.example.service.aiQuestionService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/test")
public class TestController {

	@Value("${gemini.api.key}")
	private String apiKey;
	@Autowired
	private CourseService cs;
	@Autowired
	private TestService ts;
	@Autowired
	private aiQuestionService as;
	@Autowired
	private QuestionService qs;
	@Autowired
	private StudentAnswerService sas;
	@Autowired
	private StudentService ss;
	@Autowired
	private UserService service;

	@PostMapping("/generate-test")
	public String generateTest(@RequestParam Long courseId, @RequestParam int questionCount, HttpSession session,
			Model model) throws Exception {

		if (!isLoggedIn(session))
			return "redirect:/smartai/";
		int uid = (int) session.getAttribute("uid");
		User student = service.getUserById(uid);
		Test test = new Test();
		Course c1 = cs.getById(courseId);
		test.setStudent(student);
		test.setTotalQuestions(questionCount);
		test.setStartTime(LocalDateTime.now());
		test.setCourse(c1);
		test.setTestDate(LocalDateTime.now());

		ts.save(test);
		// Generate AI Questions
		List<Question> questions = as.generateQuestions(questionCount, test, c1);
		model.addAttribute("questions", questions);
		model.addAttribute("testId", test.getId());
		model.addAttribute("stud", student.getName());

		return "test-page";
	}

	@PostMapping("/submit-test")
	public String submitTest(@RequestParam Long testId, HttpServletRequest request, Model model,HttpSession session) {

		Test test = ts.findById(testId);
		int uid = (int) session.getAttribute("uid");
		User student = service.getUserById(uid);
		List<Question> questions = qs.findByTest(test);

		int score = 0;
		int unattempted = 0;
		for (Question q : questions) {

			String selectedAnswer = request.getParameter("q" + q.getId());

			sas.save(selectedAnswer, q);
			if (selectedAnswer != null && selectedAnswer.equalsIgnoreCase(q.getCorrectAnswer())) {

				score++;
			} else if (selectedAnswer == null) {
				unattempted++;
			} else {
				continue;
			}
		}

		test.setEndTime(LocalDateTime.now());
		test.setStatus("Done");
		test.setScore(score);
		ts.save(test);

		String aifeedback = getAIFeedback(score,questions.size(),test.getCourse().getCourseName());
		Recommendation r = new Recommendation();
		r.setFeedback(aifeedback);
		r.setCourse(test.getCourse().getCourseName());
		r.setStudent(student);
		ss.saveAiFeedback(r);
		
		double per = (score * 100.0) / questions.size();
		System.out.println(per + " " + score + " " + questions.size());
		model.addAttribute("testid", testId);
		model.addAttribute("unattemted", unattempted);
		model.addAttribute("per", per);
		model.addAttribute("score", score);
		model.addAttribute("total", questions.size());
		model.addAttribute("feedback", aifeedback);
		return "result-page";
	}

	private String getAIFeedback(int score, int total, String courseName) {
		 try {
			 URL url = new URL("https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent?key=" + apiKey);
		        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

		        conn.setRequestMethod("POST");
		        conn.setRequestProperty("Content-Type", "application/json");
		        conn.setDoOutput(true);

		        int percent = (score * 100) / total;

		        String prompt = "Student scored " + percent + "% in " + courseName + " test. "
		                + "Give short feedback in 3 points:\n"
		                + "Strength:\nWeakness:\nImprovement Tip:";

		        String jsonInput = "{ \"contents\": [{\"parts\": [{\"text\": \"" + prompt + "\"}]}]}";

		        // Send request
		        OutputStream os = conn.getOutputStream();
		        os.write(jsonInput.getBytes());
		        os.flush();
		        os.close();

		        // Handle success/error
		        InputStream is = (conn.getResponseCode() == 200)
		                ? conn.getInputStream()
		                : conn.getErrorStream();

		        BufferedReader br = new BufferedReader(new InputStreamReader(is));
		        StringBuilder response = new StringBuilder();
		        String line;

		        while ((line = br.readLine()) != null) {
		            response.append(line);
		        }
		        br.close();

		        String json = response.toString();
		        System.out.println("FULL RESPONSE: " + json); // debug

		        // ✅ Jackson Parsing
		        ObjectMapper mapper = new ObjectMapper();
		        JsonNode root = mapper.readTree(json);

		        JsonNode candidates = root.path("candidates");

		        if (candidates.isArray() && candidates.size() > 0) {

		            JsonNode textNode = candidates.get(0)
		                    .path("content")
		                    .path("parts")
		                    .get(0)
		                    .path("text");

		            if (!textNode.isMissingNode()) {
		                return textNode.asText();
		            }
		        }

		        // If API gives error
		        return "AI Error: " + json;

		    } catch (Exception e) {
		        e.printStackTrace();
		        return "Exception: " + e.getMessage();
		    }
	}

	@GetMapping("/getCertificate/{tid}")
	public void certificate(@PathVariable long tid, HttpServletResponse response, HttpSession session) {

		try {

			int uid = (int) session.getAttribute("uid");
			User student = service.getUserById(uid);
			Test test = ts.findById(tid);

			String sname = test.getStudent().getName();
			String cname = test.getCourse().getCourseName();
			int score = test.getScore();
			int tqs = test.getTotalQuestions();

			Certificate c1 = new Certificate();
			c1.setCourseName(cname);
			c1.setIssueDate(LocalDateTime.now());
			c1.setScore(score);
			c1.setStudent(student);
			ss.saveCertificate(c1);

			double per = (score * 100.0) / tqs;

			if (per >= 40.0) {

				response.setContentType("application/pdf");
				response.setHeader("Content-Disposition", "attachment; filename=certificate.pdf");

				CertificateGenerator.generateCertificate(response, sname, cname, per);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public boolean isLoggedIn(HttpSession session) {
		return session.getAttribute("token") != null;
	}
	
	@GetMapping("/results")
	public String getResults(Model model,HttpSession session) {
		if(!isLoggedIn(session))
			return "redirect:/smartai/";
		int uid = (int) session.getAttribute("uid");
		User student = service.getUserById(uid);
		List<Test> tests  = ts.getTestsByStudent(student.getId()).
				stream()
                .sorted((a, b) -> b.getTestDate().compareTo(a.getTestDate()))
                .toList();
		model.addAttribute("tests",tests);
		return "result";
	}
}
