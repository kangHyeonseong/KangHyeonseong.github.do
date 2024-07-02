package main.java.com.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.fasterxml.jackson.databind.ObjectMapper;

import main.java.com.bean.MainVO;
import main.java.com.service.MainService;

@Controller
public class MainController {
 
	@Autowired
	private MainService mainService;
	
	@RequestMapping(value="/")
	public String main(Model model) {
	    try {
	        List<MainVO> tableList = mainService.selectTable();
	        
	        ObjectMapper objectMapper = new ObjectMapper();
	        String tableListJson = objectMapper.writeValueAsString(tableList);
	        
	        model.addAttribute("tableList", tableListJson);
	    } catch (Exception e) {
	        // 예외 발생 시 로그를 출력하고 적절히 처리
	    	e.printStackTrace();
	        model.addAttribute("errorMessage", "Failed to retrieve table data. Please try again later.");
	        // 에러 페이지로 리다이렉트 또는 예외 처리 로직 추가
	        return "errorPage"; // 예를 들어, errorPage.html로 리다이렉트
	    }
	    return "main/Main";
	}

	
	@RequestMapping("/loginProcess")
    @ResponseBody
    public String loginProcess(@RequestParam("userID") String userID,
                               @RequestParam("userPassword") String userPassword,
                               HttpServletRequest request) {
        System.out.println("userID :" + userID);
        System.out.println("password :" + userPassword);
        
        MainVO mainVO = new MainVO();
//        mainVO.setUsername(userID);
        mainVO.setUserid(userID);
        mainVO.setPassword(userPassword);
        
        try {
			List<MainVO> test = mainService.loginCheck(mainVO);
			for (MainVO vo : test) {
			    mainVO.setUsername(vo.getUsername());
			    mainVO.setUserid(vo.getUserid());
			    // 여기에 VO의 다른 필드들에 대한 출력 추가 가능
			}
			if (test != null && !test.isEmpty()) {
				HttpSession session = request.getSession();
				session.setAttribute("userID", mainVO.getUserid());
				session.setAttribute("userName", mainVO.getUsername());
				return "success";
			} else {
				return "failure";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
    }
	
	@RequestMapping("/MemberProcess")
    @ResponseBody
    public void MemberProcess(@RequestParam("userID") String userID,
                               @RequestParam("userPassword") String userPassword,
                               @RequestParam("userName") String userName,
                               @RequestParam("userEmail") String userEmail,
                               HttpServletRequest request) {
        
        MainVO mainVO = new MainVO();
        mainVO.setUserid(userID);
        mainVO.setPassword(userPassword);
        mainVO.setUsername(userName);
        mainVO.setUseremail(userEmail);
        
        try {
			 mainService.MemberInsert(mainVO);
		} catch (Exception e) {
			e.printStackTrace();
			return;
		}
    }
	
	@RequestMapping("/MemberCheckProcess")
    @ResponseBody
    public String MemberCheckProcess(@RequestParam("userID") String userID,
                               HttpServletRequest request) {
        
        MainVO mainVO = new MainVO();
        mainVO.setUserid(userID);
        
        try {
			int Check = mainService.memberCheck(mainVO);
			if (Check > 0) {
				return "failure";
			} else {
				return "success";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
    }
	
	@RequestMapping("/logoutProcess")
    @ResponseBody
    public String logoutProcess(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		if (session != null) {
	        session.invalidate(); // 세션 무효화
	    }
		return "success";
    }
	

	
	
//	테이블 예약 메뉴 
	
	@RequestMapping(value="/table.do")
	public String table(Model model) throws Exception {
		return "main/table";
	}
	
	@RequestMapping(value="/menu.do")
	public String menu(Model model) throws Exception {
		return "main/menu";
	}
	
	@RequestMapping("/TableProcess")
    @ResponseBody
    public void TableProcess(@RequestParam("userID") String userID,
                               @RequestParam("number_of_people") String number_of_people,
                               @RequestParam("reservation_Time") String reservation_Time,
                               @RequestParam("tableid") String tableid,
                               HttpServletRequest request) {
		System.out.println(userID);
		System.out.println(number_of_people);
		System.out.println(reservation_Time);
		System.out.println(tableid);
        
        MainVO mainVO = new MainVO();
        mainVO.setUserid(userID);
        mainVO.setNumber_of_people(number_of_people);
        mainVO.setReservation_Time(reservation_Time);
        mainVO.setTableid(tableid);
        try {
			 mainService.TableInsert(mainVO);
		} catch (Exception e) {
			e.printStackTrace();
			return;
		}
    }
}
