<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%--
  Class Name : EgovDeptSchdulManageRegist.jsp
  Description : 부서일정관리 등록 페이지
  Modification Information

      수정일        수정자           수정내용
    -------    	   --------    ---------------------------
     2008.03.09    	장동한          최초 생성
     2011.09.07		이기하			날짜관련 오류검사 추가

    author   : 공통서비스 개발팀 장동한
    since    : 2009.03.09

--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:set var="ImgUrl" value="/images/egovframework/com/cop/smt/sdm/"/>
<c:set var="CssUrl" value="/css/egovframework/com/cop/smt/sdm/"/>
<html lang="ko">
<head>
<title>부서일정관리 등록</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>


<meta http-equiv="content-type" content="text/html; charset=utf-8" >
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/cmm/com.css'/>">
<link href="<c:url value='/css/egovframework/com/cmm/button.css' />" rel="stylesheet" type="text/css"> 
<script type="text/javascript" src="<c:url value='/js/egovframework/com/sym/cal/EgovCalPopup.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="deptSchdulManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">

/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init_DeptSchdulManage(){

	   var maxFileNum = document.getElementById('posblAtchFileNumber').value;

	   if(maxFileNum==null || maxFileNum==""){
	     	maxFileNum = 3;
	    }

	   var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );

	   multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );


	   document.getElementsByName('reptitSeCode')[0].checked = true;


	   if("${deptSchdulManageVO.schdulBgnde}".length > 0){
		   var schdulBgnde = "${deptSchdulManageVO.schdulBgnde}";
		   document.getElementById("schdulBgndeYYYMMDD").value = schdulBgnde.substring(0,4) + "-" + schdulBgnde.substring(4,6) + "-" + schdulBgnde.substring(6,8);
	   }

	   if("${deptSchdulManageVO.schdulEndde}".length > 0){
		   var schdulEndde = "${deptSchdulManageVO.schdulEndde}";
		   document.getElementById("schdulEnddeYYYMMDD").value = schdulEndde.substring(0,4) + "-" + schdulEndde.substring(4,6) + "-" + schdulEndde.substring(6,8);
	   }
}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_DeptSchdulManage(){
	location.href = "<c:url value='/cop/smt/sdm/EgovDeptSchdulManageList.do' />";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_save_DeptSchdulManage(form){
	//form.submit();return;
	if(confirm("<spring:message code="common.save.msg" />")){
		if(!validateDeptSchdulManageVO(form)){
			return;
		}else{
			var schdulBgndeYYYMMDD = document.getElementById('schdulBgndeYYYMMDD').value;
			var schdulEnddeYYYMMDD = document.getElementById('schdulEnddeYYYMMDD').value;

			form.schdulBgnde.value = schdulBgndeYYYMMDD.replaceAll('-','') + fn_egov_SelectBoxValue('schdulBgndeHH') +  fn_egov_SelectBoxValue('schdulBgndeMM');
			form.schdulEndde.value = schdulEnddeYYYMMDD.replaceAll('-','') + fn_egov_SelectBoxValue('schdulEnddeHH') +  fn_egov_SelectBoxValue('schdulEnddeMM');

			if(form.schdulBgnde.value > form.schdulEndde.value) {
		        alert("종료일자는 시작일자보다  이후날짜로 선택하세요.");
		        return;
		    } else {form.submit(); }
		}
	}
}

/* ********************************************************
* 주관 부서 팝업창열기
******************************************************** */
function fn_egov_schdulDept_DeptSchdulManage(){

	var arrParam = new Array(1);
	arrParam[0] = self;
	arrParam[1] = "typeDeptSchdule";

	window.showModalDialog("<c:url value='/uss/olp/mgt/EgovMeetingManageLisAuthorGroupPopup.do' />", arrParam ,"dialogWidth=800px;dialogHeight=500px;resizable=yes;center=yes");
}

/* ********************************************************
* 아이디  팝업창열기
******************************************************** */
function fn_egov_schdulCharger_DeptSchdulManagee(){
	var arrParam = new Array(1);
	arrParam[0] = window;
	arrParam[1] = "typeDeptSchdule";

 	window.showModalDialog("<c:url value='/uss/olp/mgt/EgovMeetingManageLisEmpLyrPopup.do' />", arrParam,"dialogWidth=800px;dialogHeight=500px;resizable=yes;center=yes");
}

/* ********************************************************
* RADIO BOX VALUE FUNCTION
******************************************************** */
function fn_egov_RadioBoxValue(sbName)
{
	var FLength = document.getElementsByName(sbName).length;
	var FValue = "";
	for(var i=0; i < FLength; i++)
	{
		if(document.getElementsByName(sbName)[i].checked == true){
			FValue = document.getElementsByName(sbName)[i].value;
		}
	}
	return FValue;
}
/* ********************************************************
* SELECT BOX VALUE FUNCTION
******************************************************** */
function fn_egov_SelectBoxValue(sbName)
{
	var FValue = "";
	for(var i=0; i < document.getElementById(sbName).length; i++)
	{
		if(document.getElementById(sbName).options[i].selected == true){

			FValue=document.getElementById(sbName).options[i].value;
		}
	}

	return  FValue;
}
/* ********************************************************
* PROTOTYPE JS FUNCTION
******************************************************** */
String.prototype.trim = function(){
	return this.replace(/^\s+|\s+$/g, "");
}

String.prototype.replaceAll = function(src, repl){
	 var str = this;
	 if(src == repl){return str;}
	 while(str.indexOf(src) != -1) {
	 	str = str.replace(src, repl);
	 }
	 return str;
}
</script>
</head>
<body onLoad="fn_egov_init_DeptSchdulManage()">
<DIV id="content" style="width:712px">
<!-- 상단타이틀 -->
<form:form commandName="deptSchdulManageVO" action="${pageContext.request.contextPath}/cop/smt/sdm/EgovDeptSchdulManageRegistActor.do" name="deptSchdulManageVO" method="post" enctype="multipart/form-data">
<!--  상단 타이틀  영역 -->
<table width="100%" cellpadding="8" class="table-search" border="0">
 <tr>
  <td width="100%"class="title_left">
   <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif'/>" width="16" height="16" hspace="3" align="middle" alt="제목아이콘이미지">&nbsp;부서일정관리 등록</td>
 </tr>
</table>
<!--  줄간격조정  -->
<table width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td height="3px"></td>
</tr>
</table>
<!--  등록  폼 영역  -->

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register">
  <tr>
    <th width="20%" height="23" class="required_text" nowrap >일정구분<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif'/>" width="15" height="15" alt="필수입력표시"></th>
    <td width="80%" >
        <form:select path="schdulSe">
            <form:option value="" label="선택"/>
            <form:options items="${schdulSe}" itemValue="code" itemLabel="codeNm"/>
        </form:select>
        <div><form:errors path="schdulSe" cssClass="error"/></div>
    </td>
  <tr>
    <th width="20%" height="23" class="required_text" nowrap >중요도<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif'/>" width="15" height="15" alt="필수입력표시"></th>
    <td width="80%" >
        <form:select path="schdulIpcrCode">
            <form:option value="" label="선택"/>
            <form:options items="${schdulIpcrCode}" itemValue="code" itemLabel="codeNm"/>
        </form:select>
        <div><form:errors path="schdulIpcrCode" cssClass="error"/></div>
    </td>
 </tr>
  <tr>
    <th width="20%" height="23" class="required_text" nowrap >부서<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif'/>" width="15" height="15" alt="필수입력표시"></th>
	    <td width="80%" >
		<table width="100%" cellspacing="0" cellpadding="0" border="0">
		<tr>
			<td width="100px" style="padding:0px 0px 0px 0px;margin:0px 0px 0px 0px;">
			<form:input path="schdulDeptName" size="73" cssClass="txaIpt" readonly="true" maxlength="1000" />
			</td>
			<td style="padding:0px 0px 0px 2px;margin:0px 0px 0px 0px;">
			<a href="#" onClick="fn_egov_schdulDept_DeptSchdulManage()">
			<img src="<c:url value='/images/egovframework/com/cmm/search2.gif' />" align="middle" style="border:0px" alt="부서" title="부서">
			</a>
			</td>
		</tr>
		</table>
		<form:hidden path="schdulDeptId" />
		<div><form:errors path="schdulDeptName" cssClass="error"/></div>
 </tr>

  <tr>
    <th width="20%" height="23" class="required_text" nowrap >일정명<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif'/>" width="15" height="15" alt="필수입력표시"></th>
    <td width="80%" >
      <form:input path="schdulNm" size="73" cssClass="txaIpt" maxlength="255" />
      <div><form:errors path="schdulNm" cssClass="error"/></div>
    </td>
  </tr>
  <tr>
    <th height="23" class="required_text" >일정 내용<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif'/>" width="15" height="15" alt="필수입력표시"></th>
    <td>
        <form:textarea path="schdulCn" rows="3" cols="20" cssClass="txaClass"/>
    	<div><form:errors path="schdulCn" cssClass="error"/></div>
    </td>
  </tr>

  <tr>
    <th width="20%" height="23" class="required_text" nowrap >반복구분<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif'/>" width="15" height="15" alt="필수입력표시"></th>
    <td width="80%">
       <form:radiobutton path="reptitSeCode" value="1" />당일
       <form:radiobutton path="reptitSeCode" value="2"/>반복
       <form:radiobutton path="reptitSeCode" value="3"/>연속
       <div><form:errors path="reptitSeCode" cssClass="error"/></div>
    </td>
  </tr>
  <tr>
    <th width="20%" height="23" class="required_text" nowrap >날짜/시간<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif'/>" width="15" height="15" alt="필수입력표시"></th>
    <td width="80%" >
    <form:input path="schdulBgndeYYYMMDD" size="10" readonly="true" maxlength="10" />
    <a href="#" onClick="javascript:fn_egov_NormalCalendar(document.forms[0], document.forms[0].schdulBgndeYYYMMDD);">
    <img src="<c:url value='/images/egovframework/com/cmm/icon/bu_icon_carlendar.gif' />"  align="middle" style="border:0px" alt="달력창팝업버튼이미지">
    </a>
    &nbsp&nbsp~&nbsp&nbsp
    <form:input path="schdulEnddeYYYMMDD" size="10" readonly="true" maxlength="10" />
    <a href="#" onClick="javascript:fn_egov_NormalCalendar(document.forms[0], document.forms[0].schdulEnddeYYYMMDD);">
    <img src="<c:url value='/images/egovframework/com/cmm/icon/bu_icon_carlendar.gif' />" align="middle" style="border:0px" alt="달력창팝업버튼이미지">
    </a>&nbsp;

        <form:select path="schdulBgndeHH">
            <form:options items="${schdulBgndeHH}" itemValue="code" itemLabel="codeNm"/>
        </form:select>시
        <form:select path="schdulBgndeMM">
            <form:options items="${schdulBgndeMM}" itemValue="code" itemLabel="codeNm"/>
        </form:select>분
		~
        <form:select path="schdulEnddeHH">
            <form:options items="${schdulEnddeHH}" itemValue="code" itemLabel="codeNm"/>
        </form:select>시
        <form:select path="schdulEnddeMM">
            <form:options items="${schdulEnddeMM}" itemValue="code" itemLabel="codeNm"/>
        </form:select>분
    </td>
  </tr>
  <tr>
    <th width="20%" height="23" class="required_text" nowrap >담당자<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif'/>" width="15" height="15" alt="필수입력표시"></th>
    <td width="80%" >
		<table cellspacing="0" cellpadding="0" border="0">
		<tr>
			<td width="100px" style="padding:0px 0px 0px 0px;margin:0px 0px 0px 0px;">
			<form:input path="schdulChargerName" size="73" cssClass="txaIpt" readonly="true" maxlength="10" />
			</td>
			<td style="padding:0px 0px 0px 2px;margin:0px 0px 0px 0px;">
			<a href="#" onClick="fn_egov_schdulCharger_DeptSchdulManagee()">
			<img src="<c:url value='/images/egovframework/com/cmm/search2.gif' />" align="middle" style="border:0px" alt="담당자" title="담당자">
			</a>
			</td>
		</tr>
		</table>
		<div><form:errors path="schdulChargerName" cssClass="error"/></div>
       <form:hidden path="schdulChargerId" />

    </td>
  </tr>
<!-- 첨부파일 테이블 레이아웃 설정 Start..-->
  <tr>
	<th height="23" class="required_text" nowrap>파일첨부<img src="<c:url value='/images/egovframework/com/cmm/icon/no_required.gif'/>" width="15" height="15" alt="선택입력표시"></th>
	<td>
    	<table width="580px" cellspacing="0" cellpadding="0" border="0" align="center" class="UseTable">
			<tr>
				<td><input name="file_1" id="egovComFileUploader" type="file" title="첨부파일명 입력"/></td>
			</tr>
			<tr>
				<td>
			    	<div id="egovComFileList"></div>
			    </td>
			</tr>
   	    </table>
	 </td>
  </tr>
<!-- 첨부파일 테이블 레이아웃 End.-->
</table>

<!-- 줄간격조정  -->
<table width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td height="3px"></td>
</tr>
</table>
<center>
<!-- 목록/저장버튼  -->
<table border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<!-- 
  <td><img src="<c:url value='/images/egovframework/com/cmm/button/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
  <td background="<c:url value='/images/egovframework/com/cmm/button/bu2_bg.gif' />" class="text_left" nowrap><a href="JavaScript:fn_egov_list_DeptSchdulManage();"><spring:message code="button.list" /></a>
  </td>
  <td><img src="<c:url value='/images/egovframework/com/cmm/button/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
  <td>&nbsp;</td>
  <td><img src="<c:url value='/images/egovframework/com/cmm/button/bu2_left.gif'/>" width="8" height="20" alt="버튼이미지"></td>
  <td background="<c:url value='/images/egovframework/com/cmm/button/bu2_bg.gif' />" class="text_left" nowrap><a href="JavaScript:fn_egov_save_DeptSchdulManage(document.forms[0]);"><spring:message code="button.save" /></a>
  </td>
  <td><img src="<c:url value='/images/egovframework/com/cmm/button/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
 -->
   <td><span class="button"><input type="submit" value="<spring:message code="button.list" />" title="<spring:message code="button.list" />" onclick="javascript:fn_egov_list_DeptSchdulManage();return false;"></span></td>
   <td>&nbsp;</td>
   <td><span class="button"><input type="submit" value="<spring:message code="button.save" />" title="<spring:message code="button.save" />" onclick="javascript:fn_egov_save_DeptSchdulManage(document.forms[0]);return false;"></span></td>
</tr>
</table>
</center>

<input name="cmd" id="cmd" type="hidden" value="<c:out value='save'/>"/>
<input type="hidden" name="cal_url" id="cal_url" value="<c:url value='/sym/cal/EgovNormalCalPopup.do'/>" />
<input type="hidden" name="schdulBgnde" id="schdulBgnde" value="" />
<input type="hidden" name="schdulEndde" id="schdulEndde" value="" />

<input type="hidden" name="schdulKindCode" id="schdulKindCode" value="1" />
<!--첨부파일 갯수를 위한 hidden -->
<input type="hidden" name="posblAtchFileNumber" id="posblAtchFileNumber" value="3" />
</form:form>
</DIV>

</body>
</html>
