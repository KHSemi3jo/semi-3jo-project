$(function(){
    //상태 객체
    var status = {
        memberName:false,
        memberEmail:false,
        memberContact:false,
        memberBirth:false,
        memberAddr:false,
        ok:function(){
            return this.memberName && this.memberEmail 
            && this.memberContact && this.memberBirth && this.memberAddr;
        },
    };
    

    $("[name=memberName]").blur(function(){
        var regex =  /^[가-힣]{2,7}$/;
        var isValid =$(this).val() != "" && regex.test($(this).val());
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
         status.memberName = isValid;
    });
    
    var backupEmail = $("[name=memberEmail]").val();   
    $("[name=memberEmail]").blur(function(e){
        var regex =  /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
        var email = $("[name=memberEmail]").val();
        
        if(backupEmail == email ) {
        	$("[name=memberEmail]").removeClass("success fail fail2");
			$("[name=memberEmail]").addClass("success");
			status.memberEmail = true; //통과
			return;
		}
     
        var isValid = email != "" || regex.test($(e.target).val());
         if(isValid){//형식이 유효하다면
			$.ajax({
				url:"http://localhost:8080/rest/member/emailCheck",
				method:"post",
				data : {memberEmail : email },
				success: function(response){
					$("[name=memberEmail]").removeClass("success fail fail2");
					if(response == "Y"){
						$("[name=memberEmail]").addClass("success");
						status.memberEmail = true;
					}				       			
					else{
						$("[name=memberEmail]").addClass("fail2");
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
        var regex = /^01([0|1|6|7|8|9])([0-9]{3,4})([0-9]{4})$/;
        var contact = $(this).val();
        var isValid =contact.length != 0 && regex.test(contact);
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
         status.memberContact = isValid;
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
    
        //페이지 이탈 방지 
            //- window에 beforeunload 이벤트 설정
            // $(window).on("beforeunload",function(){
            //     return false;
            // });

		$(".change-form").submit(function(e){//기본이벤트가 있는 코드라 "e"가 필요
        $(".form-input").blur();
        if(!status.ok()){
            e.preventDefault();
        }
        else{
            $(window).off("beforeunload")
        }
    });
});