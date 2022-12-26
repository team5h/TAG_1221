<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>


<script>
var msg = "<c:out value='${msg}'/>";
var url = "<c:out value='${url}'/>";

alert(msg + "\n회원가입 축하 포인트 3000점과 배송비 할인 쿠폰이 발급되었습니다.");
location.href = url;
</script>