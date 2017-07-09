<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<title>FairMusic 회원가입</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>


<script type="text/javascript">
	$(document).ready(function(){
		$("#artist_email").on("keyup", function(){
			$.post("/FairMusic/emailCheck.do", {"artist_email":$("#artist_email").val()}, success_run)
		})
		$("#email_verify").on("click", function(){
			if($("#artist_email").val()==null){
				alert("이메일을 입력해 주세요")	
			}else{
				$.post("/FairMusic/email", {"artist_email": $("#artist_email").val()}, success_email)
			}
		})
		
		$("#email_verify_check").on("click", function(){
			alert($("#authnum_check").val())
			$.post("/FairMusic/email_check.do", {"authnum_check" : $("#authnum_check").val()}, success_eamil_check)
			
		})
		$("#artist_pass2").on("keyup", function(){
			if($("#artist_pass").val()!="" && $("#artist_pass").val()!=$("#artist_pass2").val()){
				$("#artist_pass_check").html("비밀번호가 일치하지 않습니다.")
			}else{
				$("#artist_pass_check").html("");
			}
		})
		
		$("#artist_pass").on("keyup", function(){
			if($("#artist_pass2").val()!="" && $("#artist_pass").val()!=$("#artist_pass2").val()){
				$("#artist_pass_check").html("비밀번호가 일치하지 않습니다.")
			}else{
				$("#artist_pass_check").html("");
			}
		})
		

	})
	
	function success_eamil_check(txt){
		$("#email_verify_result").html(txt);
	}
	function success_email(txt){
	/* 	$("#eamiltest").html("이메일이 전송되었습니다."); */
	}
	
	function success_run(txt){
		$("#artist_email_check").html(txt)
	}
	
	 <% String authNum = (String)session.getAttribute("authNum"); %>
	 <% String authNum_check = (String)session.getAttribute("authNum_check"); %>
	 

   function FormSubmit() {
      if (grecaptcha.getResponse() == "") {
         alert("로봇이 아님을 체크해 주세요!");
         return false;
      }else if(<%=authNum.equals(authNum_check)%>==""){
    	  alert('이메일 인증을 해주세요!');
    	  return false;
      }else {
         return true;
      }

      if (typeof (greCAPTCHA != 'undefined')) {
         if (greCAPTCHA.getResponsc() == "") { //서버단에서 한번 더 체크, 
         // 사용자가 인증하는 순간 구글의 서버로 부터 토큰 부여받음 
            alert("스팸방지코드를 확인해 주세요.");
            return false;
         }
      } else {
         return false;
      }
   }
   function CheckForm(Join){ 
	   var chk1=document.Join.check1.checked;
	   var chk2=document.Join.check2.checked;
	   if(!chk1){
           alert('약관1에 동의해 주세요');
           return false;
       }else if(!chk2) {
           alert('약관2에 동의해 주세요');
           return false;
       }else {
	    return true;
	   }
	}
   
   
   
   
   	  function timer_start(){ //초기 설정함수
		  if(artist_email==""){
			  alert("email을 입력해주세요");
		  }else{
			 tcounter=180; //3분설정 
			 t1=setInterval(Timer,1000);  
		  }
	  }

	  function Timer(){     //시간표및 조건검사
	   tcounter=tcounter-1;   
	   temp=Math.floor(tcounter/60); 
	   if ( Math.floor(tcounter/60) < 10 ) { temp = '0'+temp; }
	    temp = temp + ":";   
	   if ( (tcounter%60) < 10 ) { temp = temp + '0'; } 
	    temp = temp + (tcounter%60);
	    document.getElementById("timer_s").innerHTML=temp;    
	   if(tcounter<0) {tstop(); alert("이메일 인증 버튼을 다시 눌러주세요")}
	  }
	  
	  function tstop(){ 
	   clearInterval(t1);
	   document.getElementById("timer_s").innerHTML="인증시간이 초과되었습니다.";
	  }
  
</script>

</head>
<body class="no-sidebar">
   <div id="page-wrapper">

      <!-- Main -->
      <div id="header-wrapper">
         <div class="container" id="main">
            <div class="\35 0\25">
               <!-- Content -->
               <article id="content">
                  <header>
                     <h2>회원가입</h2>
                  </header>
               </article>
            </div>
         </div>
      </div>

      <!-- Footer -->
      <div id="footer-wrapper">
         <div id="footer" class="container">

            <div class="row">
               <section class="12u">
                  <form method="post" name ="Join" action="/FairMusic/artistregist.do" onSubmit="return (FormSubmit() && CheckForm(this));">
                     <div class="row 50%">
                        <div class="5u 12u">
                           <input type="image" src="images/facebookRegister.png"
                              width="100%">
                        </div>
                        <div class="5u 12u">
                           <input type="image" src="images/googleRegister.png"
                              width="100%">
                        </div>

                        <div class="9u 12u">
                           <input name="artist_email" placeholder="E-mail" type="email" id = "artist_email" required="required"/>
                        </div>
                        <div class="3u 12u">
                          <input type="button" value="이메일 인증하기"  data-toggle="modal" data-target="#findidModal" id="email_verify" onclick="timer_start(); this.onclick='';" />
                        </div>
                         <div class="12u">
                          	<span id="artist_email_check" style="color: red"></span>
                        </div>

                        <div class="12u">
                           <input name="artist_pass" placeholder="비밀번호" type="password" id = "artist_pass" minlength="9" required="required"/>
                        </div>
                        <div class="12u">
                           <input name="passverify" placeholder="비밀번호 확인" type="password" id="artist_pass2" minlength="9" required="required"/>
                        </div>
                        <div id="artist_pass_check" style= "color: red"></div>
                        <div class="12u">
                           <input name="artist_id" placeholder="이름" type="text" id = "artist_id" required="required"/>
                        </div>
                        
                        	<!-- 이용약관   -->
                        <div>
                        	약관(1)동의하기 : <input id="check1" name="check1" type="checkbox"/><br/>
                        	<textarea rows="5" cols="70">
제1장 총칙

제1조 목적
이 약관은 FairMusic (이하; 회사) 이 제공하는 FairMusic 및 FairMusic 관련 제반 서비스 (이하: 서비스)의 이용조건 및 절차에 관한 회사와 회원간의 권리 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.
제2조 (약관의 명시, 설명과 개정)
이 약관의 내용은 회사의 서비스 회원가입 관련 사이트에 게시하거나 기타의 방법으로 사용자에게 공지 하고, 이용자가 회원으로 가입하면서 이 약관에 동의함으로써 효력을 발생합니다.
회사는 "약관의 규제에 관한 법률", "정보통신망이용촉진 및 정보보호 등에 관한 법률", 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.
회사가 약관을 개정할 경우에는 적용일자 및 개정 사유를 명시하여 현행약관과 함께 회사 사이트의 초기화면이나 팝업화면 또는 공지사항란에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다.
회사가 전항에 따라 개정약관을 공지 통지하면서 회원에게 7일간의 기간 내에 의사 표시를 하지 않으면 의사표시가 표명된 것으로 본다는 뜻을 명확하게 고지 또는 통지하였음에도 회원이 명시적으로 거부의 의사표시를 하지 아니한 경우 회원이 개정약관에 동의한 것으로 봅니다.
회원이 개정약관의 적용에 동의하지 않는다는 명시적의사를 표명한 경우 회사는 개정 약관의 내용을 적용할 수 없으며, 이 경우 회원은 이용계약을 해지할 수 있습니다. 다만, 기존 약관을 적용할 수 없는 특별한 사정이 있는 경우에는 회사는 이용계약을 해지할 수 있습니다.
제3조 (약관 외 준칙)
이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 제정한 전자상거래 등에서의 소비자보호지침 및 관련 법령의 규정과 일반 상관례에 의합니다. 단 회사가 제공하는 서비스를 통하여 회원 상호간에 이루어진 거래에 대해서는 방문 판매 등에 관한 법률, 전자거래기본법, 소비자 보호법 등 관련 법령이 우선적으로 적용되고 회원은 이 약관의 규정을 들어 거래 상대방에 대하여 면책을 주장할 수 없습니다.
제4조 (용어의 정의)
이 약관에서 사용하는 용어의 정의는 다음과 같습니다. 
①회원: 이 약관을 승인하고 회원가입을 하여 회사와 서비스이용계약을 체결한 자를 말합니다.
②아이디(ID): 회원의 식별과 서비스 이용을 위하여 회원이 회사가 승인한 문자와 숫자의 조합대로 설정한 것을 말합니다.
회원이 회사의 서비스를 이용하게 하기 위하여 회사가 제공하는 FairMusic의 웹사이트를 말합니다
④비밀번호: 회원의 동일성 확인과 회원정보의 보호를 위하여 회원이 회사가 승인한 문자와 숫자의 조합대로 설정한 것을 말합니다.
판매자: 가상화폐를 판매할 의사로 해당 가상화폐를 회사가 온라인으로 제공하는 양식에 맞추어 등록하거나 신청한 회원을 말합니다.
구매자: 가상화폐를 구매할 의사로 해당 가상화폐를 회사가 온라인으로 제공하는 양식에 맞추어 등록하거나 신청한 회원을 말합니다.
⑦자율거래: 가상화폐를 전달하는 과정에서 회사의 참여 없이 판매자와 구매자가 서로 지정한 방법을 통해 거래하는 것을 말합니다.
⑧컨텐츠 서비스: 핀번호로 판매되는 상품권, 지류 상품권, 선불카드 등 FairMusic KRW 또는 BTC 로 구매 가능한 상품권을 제공하는 상품권몰과 가상화폐로 충전하는 선불카드 등의 유료 서비스를 말합니다.
⑨엑스페이 서비스: 가상화폐로 온라인/오프라인에서 회원(가맹점)이 재화나 용역 및 기타 서비스의 대가로 가상화폐를 통해 지급받고자 하는 경우 해당 거래가 원활하게 처리될 수 있도록 지급결제 정보와 정산의 편이를 제공하는 서비스를 말합니다.
⑩가맹점: 엑스페이 서비스에 가입하여 이용중인 개인 또는 업체를 말합니다.
제2장 서비스 이용 신청 및 승낙 (회원가입 및 탈퇴)
제5조 (이용계약의 성립)
이용자는 회사가 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.
회원가입은 회사의 승낙이 회원에게 도달한 시점으로 합니다.
이용 계약은 회원ID 단위로 체결합니다. 이용계약이 성립되면, 이용신청자는 회원으로 등록됩니다.
실명이 아니거나 타인의 이름, 전화번호 등의 개인정보를 도용하여 허위 가입한 회원은 법적인 보호를 받을 수 없으며, 이에 따른 민사, 형사상의 모든 책임은 가입한 회원이 져야 합니다.
만 19세 미만은 주식회사 FairMusic에서 제공하는 가상화폐 거래 관련 서비스 이용이 제한 될 수 있습니다.
제1항에 따른 신청에 있어 회사는 필요 시 관계법령에 의하여 이용자의 종류에 따라 전문기관을 통한 실명확인 및 본인인증을 요청할 수 있습니다. 만일, 이러한 회사의 제공 요청을 거부하여 이용자 본인임이 확인되지 않아 발생하게 되는 불이익에 대하여 회사는 책임을 지지 않습니다.
제6조 (이용신청)
이용신청은 온라인으로 회사 소정의 가입신청 양식에서 요구하는 사항을 기록하여 신청합니다.
온라인 가입신청 양식에 기재하는 모든 회원 정보는 실제 데이터인 것으로 간주하며 실명이나 실제 정보를 입력하지 않은 사용자는 법적인 보호를 받을 수 없으며, 서비스 사용의 제한을 받을 수 있습니다.
사실과 다른 정보, 거짓 정보를 기입하거나 추후 그러한 정보임이 밝혀질 경우 회사는 서비스 이용을 일시 정지하거나 영구정지 및 이용 계약을 해지할 수 있습니다. 이로 인하여 회사 또는 제3자에게 발생한 손해는 해당 회원이 모든 책임을 집니다.
회사는 회원에게 회사의 관련서비스에 대한 다양하고 유익한 정보를 E-mail, 서신우편, 전화 등을 통하여 제공할 수 있습니다.
제7조 (회원정보 사용에 대한 동의 및 이용신청의 승낙)
회원정보 사용에 대한 동의 
①회사는 회원의 개인정보를 본 이용계약의 이행과 본 이용계약상의 서비스제공을 위한 목적으로 이용합니다.
②회원이 회사 및 회사와 제휴한 서비스들을 편리하게 이용할 수 있도록하기 위해 회원 정보는 회사와 제휴한 업체에 제공될 수 있습니다. 단, 회사는 회원 정보 제공 이전에 제휴 업체, 제공 목적, 제공할 회원 정보의 내용 등을 사전에 공지하고 회원의 동의를 얻어야 합니다.
③회사는 회원의 명시적인 수신거부의사에 반하여 제휴한 서비스의 광고성 정보를 전송하지 않습니다. 단, 회사는 제휴서비스의 이용편의를 위하여 이용안내 및 상품정보 등의 SMS 및 SMS URL을 전송할 수 있으며 회원은 원치 않을 경우 회원가입탈퇴를 통해 정보수신거부를 할 수 있습니다.
④회원은 회원정보 수정을 통해 언제든지 개인 정보에 대한 열람 및 수정을 할 수 있습니다.
⑤회원이 이용신청서에 회원정보를 기재하고, 회사에 본 약관에 따라 이용신청을 하는 것은 회사가 본 약관에 따라 이용신청서에 기재된 회원정보를 수집, 이용 및 제공하는 것에 동의하는 것으로 간주됩니다.
이용신청의 승낙 
①회사는 회원이 회사 소정의 가입신청 양식에서 요구하는 모든 사항을 정확히 기재하여 이용신청을 한 경우 회원가입을 승낙할 수 있습니다. 단, 제2호, 제3호의 경우는 회사는 승낙을 유보하거나 승낙을 거절할 수 있습니다.
②회사는 다음 각 호에 해당하는 이용신청에 대하여는 승낙을 유보할 수 있습니다. 
가) 설비에 여유가 없는 경우
나) 기술상 지장이 있는 경우
다) 기타 회사의 사정상 이용승낙이 곤란한 경우
③회사는 다음 각 호에 해당하는 이용신청에 대하여는 이를 승낙하지 아니 할 수 있습니다. 
가) 이름이 실명이 아닌 경우
나) 다른 사람의 명의를 사용하여 신청한 경우
다) 이용 신청시 필요내용을 허위로 기재하여 신청한 경우
라) 사회의 안녕질서 또는 미풍양속을 저해할 목적으로 신청한 경우
회사가 정한 이용신청요건에 미비한 부분이 있었을 때
제8조 (이용계약이 중지 및 해지)
이용계약은 회원 또는 회사의 해지에 의해 종료됩니다. 회원의 해지에 의한 이용 계약의 종료와 관련하여 발생한 손해는 이용계약이 종료된 해당 회원이 책임을 부담하여야 하고, 회사는 일체의 책임을 지지 않습니다. 
①회원이 이용계약을 해지하고자 할때에는 회원 본인이 온라인을 통해 회사에 해지 신청을 하여야 합니다.
②회사는 회원이 다음 각 호의 하나에 해당하는 행위를 하였을 경우 시간을 정하여 서비스 이용을 또는 제한하거나 이용계약을 해지할 수 있습니다. 
(가) 다음 각 호와 같은 위반행위가 있는 경우 
타인의 서비스 ID 및 비밀번호를 도용한 경우
서비스 운영을 고의로 방해한 경우
가입한 이름이 실명이 아닌 경우
공공질서 및 미풍양속에 저해되는 내용을 고의로 유포시킨 경우
회원이 국익 또는 사회적 공익을 저해할 목적으로 서비스 이용을 계획 또는 실행하는 경우
타인의 명예를 손상시키거나 불이익을 주는 행위를 한 경우
서비스의 안정적 운영을 방해할 목적으로 다량의 정보를 전송하거나 광고성 정보를 전송하는 경우
정보통신설비의 오작동이나 정보 등의 파괴를 유발시키는 컴퓨터 바이러스 프로그램 등을 유포하는 경우
타인의 개인정보, 이용자ID 및 비밀번호로 부정하게 사용하는 경우
회사의 서비스 정보를 이용하여 얻은 정보를 회사의 사전 승낙없이 복제 또는 유통시키거나 상업적으로 이용하는 경우
같은 사용자가 다른 ID로 이중등록을 한 경우
회사, 다른 회원 또는 제3자의 지적재산권을 침해하는 경우
방송통신심의위원회 등 외부기관의 시정요구가 있거나 불법선거운동과 관련하여 선거관리위원회의 유권해석을 받은 경우
본 약관을 포함하여 기타 회사가 정한 이용조건에 위반한 경우
장기간 휴면 가입자에 대하여 통지할 경우 그 통지 기간 내에도 서비스이용에 대한 의사표현을 하지 않은 경우
회원이 매매부적합상품을 판매등록하거나, 기타 공공질서 및 미풍양속에 위배되는 상품거래행위를 하거나 시도한 경우
구매의사가 없이 회원의 물품을 판매 신청한 후 구매거부하는 경우 또는 회원이 실제로 물품을 판매하고자 하는 의사 없이 물품등록을 한 경우
이용자에 대한 개인정보를 그 동의 없이, 수집, 저장, 공개하는 경우
회사의 서비스 정보를 통하여 얻은 정보로 직거래를 유도하는 경우
기타 회사의 서비스개선을 위한 회사 정책상 불가피할 경우
(나) 다음 각 호의 경우 
운영자 또는 관리자가 이용에 부적합하다고 판단하는 경우
범죄와 결부된다고 객관적으로 판단하는 행위
기타 관계 법령에 위배되는 행위
서비스 이용 중지 또는 제한 절차 
① 회사는 이용제한을 하고자 하는 경우에는 그 사유, 일시 및 기간을 정하여 서면 또는 전화, 홈페이지의 메시지 기능 등의 방법을 이용하여 해당 회원 또는 대리인에게 통지합니다.
다만, 회사가 긴급하게 이용을 중지해야 할 필요가 있다고 인정하는 경우에는 전항의 과정 없이 서비스 이용을 제한할 수 있습니다.
③ 서비스 이용중지를 통지 받은 회원 또는 그 대리인은 이용중지에 대하여 이의가 있을 경우 이의 신청을 할 수 있습니다.
④ 회사는 이용중지 기간 중에 그 이용중지 사유가 해소된 것이 확인된 경우에 한하여 이용중지 조치를 즉시 해제합니다.
이용계약 해지 
① 회사가 서비스 이용을 중지 또는 제한 시킨 후 동일한 행위가 2회 이상 반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우, 또는 1. ② (가)의 위반 행위가 있는 경우, 회사는 이용계약을 해지할 수 있습니다.
② 회사가 이용계약을 해지하는 경우에는 회원등록을 말소합니다. 회사는 이 경우 회원에게 이를 통지하고, 회원등록 말소 전에 소명할 기회를 부여합니다.
제9조 (회원정보의 변경)
회원은 개인정보수정화면을 통하여 언제든지 본인의 개인정보를 열람하고 수정할 수 있습니다. 다만, 서비스 관리를 위해 필요한 실명, 생년월일, 성별, 아이디 등은 수정이 불가능합니다.
회원은 회원가입 신청시 기재한 사항이 변경되었을 경우 온라인으로 수정을 하거나 전자우편 기타 방법으로 회사에 대하여 그 변경사항을 알려야 합니다.
3. 제2항의 변경사항을 회사에 알리지 않아 발생한 불이익에 대하여 회사는 책임지지 않습니다.
제3장 회원의 의무
제10조 (회원 아이디와 비밀번호 관리에 대한 회원의 의무)
아이디와 비밀번호에 관한 모든 관리 책임은 회원에게 있습니다. 회원에게 부여된 아이디와 비밀번호의 관리소홀, 부정사용에 의하여 발생하는 모든 결과에 대한 책임은 회원에게 있습니다.
회원은 자신의 아이디가 부정하게 사용된 사실을 알게 될 경우 반드시 회사에 그 사실을 통지하고 회사의 안내에 따라야 합니다.
제2항의 경우에 해당 회원이 회사에 그 사실을 통지하지 않거나, 통지한 경우에도 회사의 안내에 따르지 않아 발생한 불이익에 대하여 회사는 책임지지 않습니다.
제11조 (정보의 제공)
회사는 회원이 서비스 이용 중 필요가 있다고 인정되는 다음과 같은 서비스 정보에 대해서 전자우편이나 서신우편 등의 방법으로 회원에게 제공할 수 있으며 회원은 원치 않을 경우 가입신청메뉴와 회원정보수정 메뉴에서 정보수신거부를 할 수 있습니다.
가상화페 거래 관련 서비스
이벤트 및 행사관련 등의 서비스
기타 회사가 수시로 결정하여 회원에게 제공하는 서비스
제4장 서비스 이용 총칙
제12조 (서비스의 종류)
회사에서 제공하는 서비스에는 가상화폐 거래 (판매관련, 구매관련, 거래API제공, 시세 정보검색 관련 서비스) 서비스, 컨텐츠 서비스(상품권몰, 선불카드), 엑스페이 등이 있습니다.
회사가 제공하는 서비스의 종류는 회사의 사정에 의하여 수시로 변경될 수 있으며, 제공되는 서비스에 대한 저작권 및 지적재산권은 “회사”에 귀속됩니다.
회사는 서비스와 관련하여 회원에게 회사가 정한 이용조건에 따라 계정, 아이디, 서비스, 포인트 등을 이용할 수 있는 이용권한만을 부여하며, 회원은 이를 활용한 유사 서비스 제공 및 상업적 활동을 할 수 없습니다.
제13조 (서비스 내용의 공지 및 변경)
회사는 서비스의 종류에 따라 각 서비스의 특성, 절차 및 방법에 대한 사항을 서비스 화면을 통하여 공지하며, 회원은 회사가 공지한 각 서비스에 관한 사항을 이해하고 서비스를 이용해야 합니다.
회사는 서비스 내용이 변경되는 경우, 적어도 변경 7일 이전에 공지하여야 하며, 회원이 공지 내용을 조회하지 않아 입은 손해에 대하여는 책임지지 않습니다.
제14조 (서비스의 유지 및 중지)
서비스의 이용은 회사의 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴 1일 24시간을 원칙으로 합니다. 다만 정기 점검 등의 필요로 회사가 정한 날이나 시간은 그러하지 않습니다.
회사는 서비스를 일정범위로 분할하여 각 범위 별로 이용가능 시간을 별도로 정할 수 있습니다. 이 경우 그 내용을 사전에 공지합니다.
회사는 다음 각 호에 해당하는 경우 서비스 제공을 중지할 수 있습니다. 
① 서비스용 설비의 보수 등 공사로 인한 부득이한 경우
② 전기통신사업법에 규정된 기간통신사업자가 전기통신 서비스를 중지했을 경우
③ 회사가 직접 제공하는 서비스가 아닌 제휴업체 등의 제3자를 이용하여 제공하는 서비스의 경우 제휴 업체등의 제3자가 서비스를 중지했을 경우
④ 기타 불가항력적 사유가 있는 경우
회사는 국가비상사태, 정전, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 정상적인 서비스 이용에 지장이 있는 때에는 서비스의 전부 또는 일부를 제한하거나 정지할 수 있습니다.
회사는 새로운 서비스로 교체 또는 기타 회사가 서비스를 제공할 수 없는 사유 발생 시 제공되는 서비스를 중단할 수 있습니다.
제15조 (회원의 결제 이용 제한)
회사는 다음 각호에 해당하는 경우 회원의 결제 이용을 제한할 수 있습니다. 
결제 이용금액이 과도한 경우
판매자와 구매자가 동일인으로 판단되는 경우
결제서비스 제공사 및 발행사의 요청이 있는 경우
기타 회사의 운영정책상 결제 이용을 제한해야 하는 경우
위의 경우에 해당하는 경우 회사는 해당 내용을 회원에게 홈페이지의 메시지등의 방법을 통해 알립니다.
정지사유가 중복발생 시에는 모든 정지해지조건을 갖추었을 경우에 한해 해제 처리할 수 있습니다.
제16조 (회원의 입금 및 출금 이용제한)
회사는 다음 각 호에 해당하는 경우 회원의 입금 및 출금 이용을 제한하거나 지연하여 승인할 수 있습니다. 
가입 회원명과 입금자명이 다르게 입금되었을 경우
회원가입 후 첫 출금액이 과도한 경우
기타 회사의 운영정책상 입금 및 출금 이용을 제한하거나 지연해야 하는 경우
회사가 정한 서비스 이용권한의 범위를 벗어난 경우
위의 경우에 해당하는 경우 회사는 해당 내용을 회원에게 홈페이지의 메시지 등의 방법을 통해 알립니다.
이용제한 및 지연 사유가 중복 발생시에는 관리자 또는 운영자가 요구하는 해제조건을 갖추었을 경우에 한해 해제 처리할 수 있습니다.
제5장 가상화폐 거래관련 서비스 이용
제17조 (가상화폐 판매등록/구매등록 등)
회사가 제공하는 서비스를 통하여 가상화폐를 판매 또는 구매하고자 하는 회원은 회사가 제공하는 등록 양식에 따라 거래를 등록하여야 합니다.
부가서비스의 이용 
가상화폐를 판매하고자 하는 회원은 거래등록 시 보다 효과적인 판매를 위하여 회사가 제공하는 부가 서비스를 신청할 수 있습니다. 부가서비스의 구체적인 내용에 대해서는 회사가 따로 정하는 바에 의합니다.
가상화폐의 판매/구매와 관련되어 FairMusic이 회원에게 제공하는 모든 서비스는 각 회원 개인의 편의 증진을 위한 이용권한만을 부여하며, 서비스 이용권한의 범위를 벗어나는 모든 유사 서비스 제공 및 상업적 활용은 금지됩니다.
가상화폐등록정보의 수정 
① 등록된 가상화폐정보를 추가하는 등의 수정은 거래진행 후에는 변경할 수 없습니다.
② 가상화폐 등록시 신청한 부가서비스의 취소는 불가능하며 추가만이 가능합니다.
③ 구매자가 선택되어 있는 경우 삭제는 불가능합니다.
수수료 외 수입 
회사 서비스를 이용하는 과정에서 회사가 취득하게 되는 이자 수입은 회사가 가상화폐대금 결제를 위한 서비스를 제공하는 대가로서의 성질을 가지며, 회원은 이에 대한 반환을 청구할 수 없습니다.
제18조 (거래 서비스 이용제한)




구분
정지사유
해제조건
정지효력
서비스 제한
로그인 외 서비스 이용 불가 
- 명의 (연락처) 미확인
- 해킹/사기 사고 발생
- 사고회원 관련자 (연락처 및 개인정보 일치)
- 결제보안 연속 오류
- 탈퇴 신청
- 기타: 관리자 판단 (정상적인 서비스 진행에 심각한 장애 유발 시) 
- 정지 사유 해결
- 관리자 판단 
로그인 이외의
거래, 충전, 출금 불가 
로그인 제한
- 비밀번호 연속 오류
- 해킹/사기 사고 발생
- 명의 도용으로 의심되는 경우
- 기타: 관리자 판단
- API를 활용한 유사 서비스 제공 및 상업적 활용이 의심되는 경우 
- 정지 사유 해결
- 관리자 판단 
로그인 불가
일부 서비스 제한
(구매, 판매, 입출금 제한)
관리자 판단에 따라 구매/판매/입출금 등 특정 서비스 외 이용은 문제 없다고 판단될 경우 부분 제한으로 처리할 수 있음.
- 정지 사유 해결
- 관리자 판단 
특정 서비스 이용불가
제19조 (가상화폐 보관에 관한 내용)
회사는 6개월 이상 접속이 없는 회원을 대상으로 보유하고 있는 가상화폐 또는 출금하지 않은 가상화폐를 예기치 않은 사고로부터 보다 안전하게 보관하기 위하여 당시 시세로 현금화 하여 보관할 수 있습니다.
회사는 6개월 이상 미 접속한 회원이 보유하고 있던 가상 화폐의 반환 요구 시 보관하고 있는 상태로 반환하여 줍니다.
제6장 서비스 이용 수수료
제20조 (가상화폐 거래 관련 서비스 수수료의 내용)
회사는 구매자/판매자에게 인터넷을 통한 서비스를 제공하는 대가로 수수료를 부과합니다. 수수료는 회사의 홈페이지 이용방법에 명시되어 있으며, 회사 및 시장의 상황에 따라 변경될 수 있습니다.
회사는 새로운 서비스로 교체 또는 기타 회사가 서비스를 제공할 수 없는 사유 발생 시 제공되는 서비스를 중단할 수 있습니다.
제7장 컨텐츠 서비스 이용
제21조 (상품권몰 서비스 이용)
회사가 핀번호를 이용한 온라인/오프라인 상품권과 선불카드, 모바일 상품권 및 지류 상품권 등 유료 상품을 회원에게 판매하는 서비스이며 아래와 같은 품목을 취급합니다. 
온라인/오프라인 상품권
모바일 서비스(충전요금제, 문자쿠폰 등)
디지털 컨텐츠(웹하드, 음악, 영화, 만화 등)
기타 회사가 정하는 품목
회사는 각 상품에 대한 핀번호 또는 지류상품권을 제휴사로부터 제공받아 해당 상품을 구매한 회원에게 제공합니다.
회원은 상품권몰 서비스 이용상의 모든 문의 및 문제에 대하여 각 상품을 취급하는 제휴사를 통하여 처리 할 수 있습니다. 단, 핀번호 이상유무에 대하여는 회사에 문의하여 처리 할 수 있습니다.
회원은 KRW 또는 BTC를 사용하여 상품권, 선불카드류, 모바일 서비스의 관련 상품을 구매할 수 있습니다.
BTC 결제의 경우 결제 당시의 시세에 따라 BTC 수량이 정해집니다.
BTC 결제 시, FairMusic 거래소에 해당 비트코인을 시장가로 판매하여 KRW로 결제되므로, 비트코인의 시세 변동에 따라 약간의 결제 비트코인 수량의 차이가 발생할 수 있습니다.
지류 상품권의 경우, 배송기간은 배송업체의 상황에 따라 달라질 수 있습니다.
회원은 원칙적으로 상품권몰 서비스 이용에 대한 환불 및 취소를 할 수 없습니다.
제22조 (선불카드 서비스 이용)
선불카드의 발급 
선불카드는 이 약관에 동의한 후 선불카드 페이지에서 발급 가능합니다.
선불카드의 발급 및 배송을 위해 회사가 정하는 일정 금액의 카드발급 수수료를 차감합니다.
회사의 제휴사에서 발급하는 카드이므로, 제휴사 홈페이지의 가입 및 카드발급 신청이 별도로 필요합니다.
선불카드의 충전 및 이용 
선불카드의 충전은 비트코인으로만 가능합니다.
회원이 보유하고 있는 비트코인의 수량과 충전신청 시점의 시세 기준으로 실제 카드 충전금액이 결정됩니다.
회원은 다음의 각 호에 해당하는 경우 선불카드 충전 및 이용에 제한을 받을 수 있습니다. 
회원이 선불카드를 위변조하는 등 부정한 방법으로 사용한 경우
회원이 관련 법규 및 이용 약관을 위반한 경우
회사 및 제휴사의 휴업일 또는 시스템 보수작업이 있을 경우
기타 천재지변 등 카드 운영시스템에 불가항력의 사유가 발생한 경우
위의 사유로 회원이 선불카드를 충전 및 이용하지 못함으로써 손해를 입은 경우 회원은 손해배상 청구를 할 수 없습니다.
선불카드 이용 관련 서비스는 제휴사의 이용약관에 의거합니다.
선불카드 서비스는 정부정책이나 회사 및 제휴사의 사정 또는 관련법령 등에 따라 변경 또는 중단될 수 있습니다.
선불카드의 분실 또는 도난 및 교환과 관련된 사항은 제휴사의 이용약관에 따릅니다.
선불카드의 환불 및 취소 
회원은 원칙적으로 선불카드에 충전한 금액에 대한 환불 및 취소를 할 수 없습니다.
회원은 다음 각 호에 해당하는 경우 선불카드에 충전되어있는 금액의 환불을 받을 수 있습니다. 본인 명의의 은행계좌에 원화로 환불되며, 일부 이용금액이 있을 경우 선불카드에 남아있는 잔액이 환불됩니다. 
천재지변 등의 사유로 선불카드의 이용이 불가한 경우
카드의 결함으로 인해 선불카드의 이용이 불가한 경우
선불카드의 수수료 
선불카드의 수수료에는 발급 / 충전 / 출금 및 송금 수수료가 있으며 수수료는 회사와 제휴사의 홈페이지 이용방법에 명시되어 있습니다.
선불카드의 수수료는 회사와 제휴사 및 시장의 상황에 따라 변경될 수 있습니다.
제23조 (엑스페이 서비스 이용)
엑스페이 서비스의 이용 
회사는 엑스페이 제공을 위해 다음 각 호의 업무를 수행합니다. 
가맹점이 결제 요청 시 필요한 엑스페이 결제 URL, 페이지 및 시스템 제공
결제 시 비트코인 수량 환산을 위한 엑스페이 시세 및 결제 관련 세부정보 제공
정산을 위한 결제 내역 정보 조회 서비스 제공
기타 엑스페이 운영과 관련하여 회사가 정하는 업무
가맹점은 엑스페이를 이용함에 있어 다음 각 호의 업무를 수행합니다. 
엑스페이 결제와 관련된 고객 응대, 환불 및 취소 처리
엑스페이의 이용약관을 숙지하고 회원에게 비트코인 결제와 관련된 주의사항에 대한 고지 의무 이행
가맹점은 사회의 미풍양속을 저해하거나 법적으로 금지된 상품이나 서비스 및 허위 또는 과장된 정보를 포함한 컨텐츠 등을 판매하려는 목적으로 엑스페이를 이용해서는 안됩니다.
고객이 기본적으로 0.0001 BTC이상의 전산망 수수료를 지불해야 정상적인 엑스페이 서비스가 처리가 됩니다. 고객이 0.0001 BTC미만의 전산망 수수료를 지불해 생기는 문제에 대해서는 회사가 책임을 지지 않습니다.
엑스페이는 비트코인 네트워크 상황이나 시스템 보수작업 및 기타 불가항력적인 이유로 인해 정상적인 처리까지 시간 지연이 발생할 수 있으며, 회사가 이에 따른 책임을 지지 않습니다.
엑스페이는 비트코인 시세에 기반한 서비스이므로, 시세의 급등 및 급락 시 서비스가 일시적으로 중단될 수 있습니다.
엑스페이 결제 
엑스페이 결제는 가맹점이 비트코인으로 받은 판매 대금을 실시간으로 가맹점의 엑스페이 계정에 정산합니다.
가맹점은 엑스페이를 이용하여 원화 와 비트코인 중 정산방식을 선택할 수 있습니다. 
원화 정산 : 고객이 엑스페이를 통해 결제한 비트코인을 매도하여 가맹점에게 원화로 정산 됩니다.
비트코인 정산 : 고객이 엑스페이를 통해 결제한 비트코인이 가맹점 계정에 그대로 비트코인으로 정산 됩니다.
엑스페이 결제 취소 및 환불 
엑스페이 결제 후 거래 취소 또는 환불 요청 시 가맹점의 책임 하에 본인 확인을 통해 고객에게 환불을 진행합니다. 단, 가맹점의 정산방식에 따라 비트코인 또는 결제 당시 시세로 환산된 원화로 환불이 가능하며 환불 방식에 대해서는 가맹점의 이용안내를 통해 확인이 가능합니다.
원화 환불 고객에게 원화로 환불할 경우, 가맹점은 엑스페이 계정을 통해 고객에게 환불한 정산 금액을 돌려 받습니다.
비트코인 환불 고객에게 비트코인으로 환불할 경우, 가맹점은 고객이 요청하는 비트코인 주소에 환불하는 것을 원칙으로 합니다. 이때 전산망 수수료는 가맹점이 부담합니다.
원화정산을 선택한 가맹점에서 고객이 엑스페이 결제 대기시간 10분을 초과하여 입금하는 경우, 시세 변동에 따라 결제 비트코인 수량이 변경될 수 있습니다.
시세 변동 또는 요청된 비트코인 수량보다 적은 입금으로 인하여 추가 입금이 필요한 경우, 회사는 가맹점을 통해 고객에게 부족한 비트코인 수량을 요구할 수 있으며, 초과 입금된 경우에는 고객은 가맹점을 통해 환불요청을 할 수 있습니다.
고객이 거래의 취소 및 환불을 요구하는 경우에는 가맹점이 이를 접수하여 엑스페이를 통하여 취소 및 환불을 처리하거나 가맹점 책임 하에 직접 환불을 처리합니다.
비트코인 전송 시 간헐적으로 발생하는 비트코인 전송 무한대기에 대해서는 15일 이내에 거래가 취소 될 수 있습니다.
가맹점의 과실로 인한 비트코인 결제 지연 또는 취소나, 환불 시 비트코인 주소를 잘못 입력해서 발생하는 모든 문제에 대한 책임은 가맹점에게 있습니다.
엑스페이 수수료 및 대금 정산 
서비스 수수료율 
가맹점에 정산 시 판매금액의 일정 비율의 수수료를 차감합니다.
서비스 수수료율은 회사의 홈페이지에 명시되어 있으며, 서비스 수수료율은 회사 정책에 따라 변경될 수 있습니다.
정산 시점은 고객이 결제를 완료한 때가 아니라 고객이 비트코인을 입금한 뒤 해당 거래가 비트코인 네트워크(블록체인)에서 3컨펌이 완료된 때를 기준으로 합니다.
엑스페이 정산대금은 3영업일 이후 출금 가능합니다.
제8장 개인 정보 보호
제24조 (회원정보 사용에 대한 동의)
회원의 개인 정보에 대해서는 회사의 개인정보 보호정책이 적용됩니다. 회원이 이용 신청서에 회원정보를 기재하고, 회사에 본 약관에 따라 이용 신청 하는 것은 회사가 본 약관에 따라 이용신청서에 기재된 회원정보를 수집, 이용 및 제공하는 것에 동의하는 것으로 간주 됩니다. 회원정보의 관리 책임자는 회사가 정하는 운영자입니다.
회원이 회사 및 회사와 제휴한 서비스들을 유용하고 편리하게 이용할 수 있도록 하기 위해 회사는 본 계약에 정해진 절차에 따라 회원 정보를 이용하거나 회사와 제휴한 업체에 제공할 수 있습니다. 단, 회사는 전기통신 기본법 등 법률의 규정에 의해 국가기관의 요구가 있는 경우, 범죄에 대한 수사상의 목적이 있거나 정보통신윤리위원회의 요청이 있는 경우 또는 기타 관계법령에서 정한 절차에 따른 요청이 있는 경우를 제외하고는 언제나 제휴 업체, 제공 목적, 제공할 회원 정보 내용 등을 사전에 공지하고 회원의 동의를 얻은 경우에 한하여 회원의 정보를 제3자에게 공개하거나 배포합니다. 단, 거래시 거래가 정상적으로 성사 되어 쌍방 당사자간에 거래와 관련된 상호 정보를 교환하는 경우에는 본 조항의 제한이 적용되지 않습니다.
이용 신청자 또는 회원이 이용 신청 시 기재한 신상정보가 변경 되었을 경우에는 즉시 운영자 또는 회원정보 변경 창을 통해서 관련사항을 수정하여야 합니다. 단, 회원 ID와 이름, 생년월일, 성별 등은 신용관리상 변경할 수 없습니다.
전항의 경우, 수정하지 않은 정보로 인한 각종 손해는 당해 회원이 부담하며, 회사는 이에 대하여 아무런 책임을 지지 않습니다.
회원이 회사의 개인정보 취급에 대해서 불만을 가질 경우 서면상으로 회사에 관련 내용을 제출하여야 하며 이 경우 회사는 적법한 절차에 따라 회원의 불만을 처리해야 합니다.
회원의 이용 계약 해지는 제8조에 따르며, 이용계약이 해지된 경우 회원의 신상정보는 전자상거래 등에서의 소비자 보호에 관한 법률 등 관계법령에서 명시한 자료를 보관하며 이후에는 삭제합니다.
회사는 개인정보를 파기하여야 할 의무가 있는 경우라도 상법 등 관계법령의 규정에 의하여 보존할 필요가 있는 경우에는 관계법령에서 정한 기간동안 회원의 개인정보를 보관합니다. 단, 수집 된 주민등록번호의 뒷자리는 마스킹 처리 후 보관합니다.단, 수집 된 주민등록번호의 뒷자리는 마스킹 처리 후 보관합니다.
특정 서비스 사용을 위해 개인정보를 수집하거나 전송할 필요가 있을 경우, 회사는 반드시 회원에게 이와 같은 사실을 사전 공지하고 회원의 동의를 구해야 합니다.
회원이 제공한 개인정보는 회원의 동의 없이 목적 외의 이용으로 제공할 수 없습니다. 단, 다음의 경우는 예외로 합니다.
제9장 손해배상 및 면책조항
제25조 (손해배상)
회사는 본 약관에서 규정한 매매 규칙을 벗어난 거래를 통해서 발생한 일체의 사고에 대해서 책임을 지지 않으며, 판매자 또는 구매자의 과실로 인해 발생한 분쟁에 대해서 책임을 지지 않습니다. 회사의 제휴사에 의해 발생한 피해는 제휴사의 약관에 준하며, 제휴사와 회원 사이에 분쟁 해결하는 것을 원칙으로 합니다.
제26조 (면책조항)
회사는 다음 각 호에 해당하는 경우에는 책임을 지지 않습니다. 
가) 전시, 사변, 천재지변 또는 이에 준하는 국가 비상 사태 등 불가항력적인 경우
나) 이용자의 고의 또는 과실로 인하여 손해가 발생한 경우
다) 전기통신사업법에 의한 타 기간 통신사업자가 제공하는 전기통신서비스 장애로 인한 경우
회사는 이용자의 귀책 사유로 인한 서비스 이용의 장애에 대하여 책임을 지지 아니합니다.
회사는 이용자의 게시 또는 전송한 자료의 내용에 관하여는 책임을 지지 아니 합니다.
회사는 가상화폐 발행 관리 시스템 또는 통신 서비스 업체의 서비스 불량으로 인한 또는 정기적인 서버 점검 시간으로 인하여 가상화폐전달에 하자가 발생하였을 경우는 책임을 지지 않습니다.
FairMusic거래소에 등록된 가상화폐의 내용은 각 회원이 등록한 것으로 회사는 등록내용에 대한 일체의 책임을 지지 않습니다.
제27조 (대리 및 보증의 부인)
회사는 가상화폐을 판매하거나 구매하고자 하는 회원을 대리할 권한을 갖고 있지 않으며, 회사의 어떠한 행위도 판매자 또는 구매자의 대리 행위로 간주되지 않습니다.
회사는 회사가 제공하는 서비스를 통하여 이루어지는 회원간의 판매 및 구매와 관련하여 판매의사 또는 구매의사의 사실 및 진위, 적법성에 대하여 보증하지 않습니다.
회사는 회사에 링크된 사이트가 취급하는 상품 또는 용역에 대하여 보증책임을 지지 아니합니다. 회사와 회사에 연결된 사이트는 독자적으로 운영되며 회사는 회사 연결사이트와 회원간에 행해진 거래에 대하여 어떠한 책임도 지지 아니합니다.
제28조 (관할법원 및 준거법)
회사의 요금체계 등 서비스 이용과 관련하여 분쟁이 발생될 경우, 회사의 본사 소재지를 관할하는 법원을 관할 법원으로 하여 이를 해결합니다.
서비스 이용과 관련하여 회사와 회원 간의 소송에는 대한민국 법을 적용합니다.
부칙
이 약관은 2015년 5월 25일부터 적용됩니다. 
이 약관은 2015년 11월 26일부터 적용됩니다. 
이 약관은 2016년 6월 07일부터 적용됩니다. 
							</textarea>
                        		
                       
                        </div>
						
						<div>
							약관(2)동의하기 : <input id="check2" name="check2" type="checkbox"/><br/>
                      	 	<textarea rows="5" cols="70">
개인정보 취급방침

FairMusic은 고객의 개인정보를 매우 중요시하며, 고객의 개인정보를 보호하여 개인정보 유출로 인한 피해가 발생하지 않도록 하기 위하여 '정보통신망 이용촉진 및 정보보호에 관한 법률' 및 '개인정보 보호법' 등 정보통신 서비스 제공자가 준수하여야 할 관련 법령상의 규정을 준수하며, 이를 바탕으로 다음과 같은 개인정보취급방침을 작성하여 고객님들의 개인정보가 어떠한 용도와 방식으로 이용되고 있으며, 개인정보보호를 위해 어떠한 조치가 이루어지고 있는지 알려드립니다. 

당사의 개인정보취급방침은 개인정보보호와 관련한 법률 또는 지침의 변경, 당사 정책의 변화에 따라 변경될 수 있으므로, 회원께서는 당사 사이트 방문 시 수시로 확인하여 주시기 바랍니다. 
총칙
주식회사 FairMusic (이하 "회사"라 합니다) 이용자들의 개인정보보호를 매우 중요시하며, 이용자가 회사의 서비스를 이용함과 동시에 온라인상에서 회사에 제공한 개인정보가 보호 받을 수 있도록 최선을 다하고 있습니다. 이에 회사는 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 정보통신 서비스 제공자가 준수하여야 할 관련 법규상의 개인정보보호 규정 및 정보통신부가 제정한 개인정보보호지침을 준수하고 있습니다. 
회사는 개인정보 취급방침을 통하여 이용자들이 제공하는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려 드립니다. 
회사는 개인정보 취급방침을 홈페이지 첫 화면에 공개함으로써 이용자들이 언제나 용이하게 보실 수 있도록 조치하고 있습니다. 
회사의 개인정보 취급방침은 정부의 법률 및 지침 변경이나 회사의 내부 방침 변경 등으로 인하여 수시로 변경될 수 있으므로 이용자들께서는 사이트 첫 페이지에 고지되는 개인 ㅊ정보취급방침을 사이트 방문 시 수시로 확인하시기 바랍니다. 
1. 개인정보의 수집목적 및 이용목적
"개인정보"라 함은 생존하는 개인에 관한 정보로서 당해 정보에 포함되어 있는 성명, 생년월일 등의 사항에 의하여 당해 개인을 식별할 수 있는 정보(당해 정보만으로는 특정 개인을 식별할 수 없더라도 다른 정보와 용이하게 결합하여 식별할 수 있는 것을 포함)를 말합니다.
개인회원에 대하여 수집하는 개인정보 항목과 수집 및 이용목적은 다음과 같습니다.
- 성명, 아이디, 비밀번호, 여권번호(외국인에 한함), 이메일 주소 :본인확인 및 회원 가입의사 확인
- 은행계좌정보, 신분증 사본(생년월일을 제외한 나머지 정보는 마스킹), 휴대전화번호 : 결제 및 출금을 위한 본인인증 - 기타 선택항목 : 개인맞춤 서비스를 제공하기 위한 자료
- 불량회원의 부정 이용 방지와 비인가 사용 방지 
2. 수집하는 개인정보 항목 및 수집방법
회사는 이용자들이 회원서비스를 이용하기 위해 회원으로 가입하실 때 서비스 제공을 위한 필수적인 정보들을 온라인상에서 입력 받고 있습니다. 회원 가입 시에 받는 필수적인 정보는 이름, 이메일 주소 등입니다. 또한 양질의 서비스 제공을 위하여 이용자들이 선택적으로 입력할 수 있는 사항으로서 전화번호, 은행계좌번호 등을 입력 받고 있습니다. 또한 거래소 내에서의 설문조사나 이벤트 행사 시 통계분석이나 경품제공 등을 위해 선별적으로 개인정보 입력을 요청할 수 있습니다.
이용자의 기본적 인권 침해의 우려가 있는 민감한 개인정보(인종 및 민족, 사상 및 신조, 출신지 및 본적지, 정치적 성향 및 범죄기록, 건강상태 및 성생활 등)는 수집하지 않으며 부득이하게 수집해야 할 경우 이용자들의 사전동의를 반드시 구할 것입니다. 그리고, 어떤 경우에라도 입력하신 정보를 이용자들에게 사전에 밝힌 목적 이외에 다른 목적으로는 사용하지 않으며 외부로 유출하지 않습니다.
3. 수집하는 개인정보의 보유 및 이용기간
회사가 이용자의 개인정보를 수집하는 경우 그 보유기간은 회원가입 하신 후 해지(탈퇴신청, 직권탈퇴 포함)시까지 입니다. 또한 해지 시 회사는 이용자의 개인정보를 파기하며 개인정보가 제3자에게 제공된 경우에는 제3자에게도 파기하도록 지시합니다. 다만 상법 등 법령의 규정에 의하여 보존할 필요성이 있는 경우에는 법령에서 규정한 보존기간 동안 거래내역과 최소한의 기본정보를 보유하고 있고 있으며 보유기간을 이용자에게 미리 고지하고 그 보유기간이 경과하지 아니한 경우와 개별적으로 이용자의 동의를 받을 경우에는 약속한 보유기간 동안 개인정보를 보유합니다.
- 계약 또는 청약철회 등에 관한 기록 : 5년
- 대금결제 및 재화등의 공급에 관한 기록 : 5년
- 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년 
이용자의 동의를 받아 보유하고 있는 거래정보 등을 이용자가 열람을 요구하는 경우 회사는 지체 없이 그 열람, 확인할 수 있도록 조치합니다 
							</textarea>
                        </div>
                     </div>
                     <br />
                     <div class="row 50%" style="float: left;">
                        <div class="12u" align="right">
                           <ul class="actions">

                              <li><input type="submit" name="submit" value="회원 가입"/></li>
                              <li>
                              <input type="button" value="가입 취소" onclick="location.href='/FairMusic/view.do?leftpath=Side_Left.jsp&viewpath=../content.jsp&rightpath=Side_Right.jsp'"/>
                              </li>
                           </ul>
                        </div>
                     </div>
                     <div class="g-recaptcha"
                        data-sitekey="6LeWpScUAAAAAEZHSU8Ofsqp1B06zp7EZCi1Oem_"
                        style="float: right;"></div>
                     

                  </form>
               </section>
            </div>
         </div>
         <div id="copyright" class="container">
            <ul class="menu">
               <li>&copy; Untitled. All rights reserved.</li>
               <li>Design: <a href="#">FariMusic</a></li>
            </ul>
         </div>
      </div>

   </div>

   <div class="modal fade" id="findidModal" role="dialog">
      <div class="modal-dialog modal-lg">
         <!-- Modal content-->
      <div class="modal-content">
         <div class = "modal-header">
         <h3>이메일이 전송되었습니다.</h3>
      </div>
        <div class = "modal-body">
	      <div class="row">
				<div class="col-lg-12">
					<span class="label label-info">이메일 검증</span>
					<span id="email_verify_result" style="color: red"></span>
				</div>
				
				<div class="col-lg-12">
					<div id="timer_s" style="color: red"></div>
				</div>
				
				<div class="col-lg-12">
					<span class="label label-info">인증번호 7자리를 입력하세요</span> 
					<input type="text" name="authnum"  id="authnum_check"/>
					<span id="authnum_check_result"></span>
				</div>
				<div class="col-lg-12">
					<button type="submit" class="btn btn-lg btn-default" id="email_verify_check">확인</button>
				</div>
				
			</div>
			
        </div>
        <div class="modal-footer">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">검증완료</button>
        </div>
      </div>
      </div>
   </div>
   


   <!-- Scripts -->

   <script src="assets/js/jquery.min.js"></script>
   <script src="assets/js/jquery.dropotron.min.js"></script>
   <script src="assets/js/skel.min.js"></script>
   <script src="assets/js/util.js"></script>
   <!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
   <script src="assets/js/main.js"></script>

</body>
</html>