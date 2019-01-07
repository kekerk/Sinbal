package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import exception.CartEmptyException;
import exception.LoginException;
import logic.Cart;
import logic.User;

@Component //객체화
@Aspect    //현재 객체가 AOP 객체 설정
public class CartAspect {
	/*
	 * advice 중에 Around : 핵심 logic의 실행 전, 실행 후 모두 호출되는 AOP 메서드
	 */
	@Around("execution(* controller.Cart*.check*(..))") // 핵심 알고리즘 "execution(* controller.Cart*.check*(..))"
	public Object userLoginCheck(ProceedingJoinPoint joinPoint) throws Throwable{
		// joinPoint.getArgs() : 핵심알고리즘의 매개변수 목록
		HttpSession session = (HttpSession)joinPoint.getArgs()[0];
		Cart cart = (Cart) session.getAttribute("CART");
		User loginUser = (User) session.getAttribute("loginUser");
		if(loginUser == null) { //로그인이 안된 경우
			throw new LoginException("로그인 후 거래하세요","../user/loginForm.shop");
		}
		if(cart == null || cart.isEmpty()) {
			throw new CartEmptyException("장바구니가 비었습니다.","../item/list.shop");
		}
		Object ret = joinPoint.proceed(); 
		return ret;
	}
}
