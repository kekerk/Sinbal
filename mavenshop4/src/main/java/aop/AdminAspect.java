package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import exception.LoginException;
import logic.User;

@Component 
@Aspect  
public class AdminAspect {
	@Around("execution(* controller.Admin*.*(..))")
	public Object adminCheck(ProceedingJoinPoint joinPoint) throws Throwable{
		Object[] args = joinPoint.getArgs();//Around annotation에서 args를 제거하고 동적으로 할당.
		User loginUser = null;
		HttpSession session = null;
		for(Object o : args) {
			if(o instanceof HttpSession) {
				session = (HttpSession)o;
				loginUser = (User) session.getAttribute("loginUser");
			}
		}
		if(loginUser == null) {
			throw new LoginException("로그인 후 이용하세요","../user/loginForm.shop");
			}
		if(!loginUser.getUserId().equals("admin")) {
			throw new LoginException("관리자만 사용이 가능합니다.","../user/mypage.shop?id="+loginUser.getUserId());
		}
		Object ret = joinPoint.proceed();
		return ret;
	}
	
	
}
