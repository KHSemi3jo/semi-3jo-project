
$(function(){
    //상태 객체
    var status = {
        memberId:false,
        memberPw:false,
        pwCheck:false,
        memberName:false,
        memberEmail:false,
        memberContact:false,
        memberBirth:false,
        memberAddr:false,
        policy:false,
        ok:function(){
            return this.memberId && this.memberPw && this.pwCheck&&this.memberName && this.memberEmail 
            && this.memberContact && this.memberBirth && this.memberAddr && this.policy;
        },
    };

    $("[name=memberId]").blur(function(e){
        var regex =  /^[a-z0-9]{5,20}$/;
        var isValid = regex.test($(e.target).val());
        
        if(isValid){//형식이 유효하다면
            $.ajax({
                url:"http://localhost:8080/rest/member/idCheck",
                method:"post",
                //data: {memberId : e.target.value}, //JS
                data: {memberId : $(e.target).val() },
                success : function(response){
                    $(e.target).removeClass("success fail fail2"); //통신끝나고 지워      
                    if(response == "Y"){//사용가능
                        $(e.target).addClass("success");
                        status.memberId = true;
                    }
                    else{//사용불가(중복)
                        $(e.target).addClass("fail2");
                        status.memberId = false;
                    }
                },
            });
        }
        else{//유효하지 않다면(1차 실패)
            $(e.target).removeClass("success fail fail2");       
            $(e.target).addClass("fail");
            status.memberId = false;
        }
    });

    $("[name=memberPw]").blur(function(){
        var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
        var isValid = regex.test($(this).val());
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
         status.memberPw = isValid;
         //비밀번호 확인창에 강제로 blur이벤트를 발생시킨다(트리거)
         $("#password-check").blur();//너무 많으면 혼돈~ 한 두개 정도에 적용
    });

    $("#password-check").blur(function(){
        var originPw = $("[name=memberPw]").val();
        var checkPw = $(this).val();
        $(this).removeClass("success fail fail2");
        if(originPw.length == 0){//미입력이면
            $(this).addClass("fail2");
            status.pwCheck = false;
        }
        else if(originPw == checkPw){//일치하면
            $(this).addClass("success"); 
            status.pwCheck = true;
        }
        else{//비밀번호 불일치
            $(this).addClass("fail");
            status.pwCheck = false;
        }
    });

    $("[name=memberName]").blur(function(){
        var regex =  /^[가-힣]{2,7}$/;
        var isValid =regex.test($(this).val());
        $(this).removeClass("success fail");
         if(isValid){
			  $(this).addClass("success"); 
              status.memberName = true;
		 }
		 else{
			 $(this).addClass("fail");
            status.memberName = false;
		 }
         
    });
    $("[name=memberEmail]").blur(function(e){
        var regex =  /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
        var isValid =regex.test($(this).val());
        
        if(isValid){//형식이 유효하다면
			$.ajax({
				url:"http://localhost:8080/rest/member/emailCheck",
				method:"post",
				data : {memberEmail : $(e.target).val()},
				success: function(response){
					$(e.target).removeClass("success fail fail2");
					if(response == "Y"){
						$(e.target).addClass("success");
						status.memberEmail = true;
					}
					else{
						$(e.target).addClass("fail2");
						status.memberEmail = false;
					}
				},
				error : function(){
					alert("서버와의 통신이 원할하지 않습니다");
				}
			});
		}
		else{
			$(e.target).removeClass("success fail fail2");
			$(e.target).addClass("fail");
			status.memberEmail = false;
		}
    });
    $("[name=memberContact]").blur(function(){
        var regex = /^01([0|1|6|7|8|9])([1-9]{3,4})([0-9]{4})$/;
        var contact = $(this).val();
        var isValid =regex.test(contact);
        $(this).removeClass("success fail");
         if(isValid){
			  $(this).addClass("success"); 
              status.memberContact = true;
		 }
		 else{
			 $(this).addClass("fail");
            status.memberContact = false;
		 }
    });
    $("[name=memberBirth]").blur(function(){
        var regex =  /^(19[0-9]{2}|20[0-9]{2})-(0[1-9]|1[0-2])-(0[1-9]|1[0-9]|2[0-9]|3[01])$/;
        var isValid =$(this).val().length == 0 || regex.test($(this).val());
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
         status.memberBirth = isValid;
    });
    $("[name=memberPost],[name=memberAddr1],[name=memberAddr2]").blur(function(){
        //this 사용 불가(확실히 누군지 알 수 없음)-수동으로 선택해줘야함
        var post =  $("[name=memberPost]").val();
        var addr1 = $("[name=memberAddr1]").val();
        var addr2 = $("[name=memberAddr2]").val();    
        var isValid =  post.length > 0 && addr1.length > 0 && addr2.length > 0;
         if(isValid){
			  $("[name=memberPost],[name=memberAddr1],[name=memberAddr2]").removeClass("success fail").addClass("success"); 
              status.memberAddr = true;
		 }
		 else{

			 $("[name=memberPost],[name=memberAddr1],[name=memberAddr2]").removeClass("success fail").addClass("fail");
            status.memberAddr = false;
		 }
    });
    //약관동의 전체체크시 가입가능
     $(".check-all").change(function(){
        var isVaild = $(this).prop("checked");
        if(isVaild){
            status.policy = true;
        }
    });
    
        //페이지 이탈 방지 
            //- window에 beforeunload 이벤트 설정
            $(window).on("beforeunload",function(){
                return false;
            });

    $(".join-form").submit(function(e){//기본이벤트가 있는 코드라 "e"가 필요
        $(".form-input").blur();
        if(!status.ok()){
            e.preventDefault();
        }
        else{
            $(window).off("beforeunload")
        }
    });



});