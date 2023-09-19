$(function(){
    //상태 객체
    var status = {
        id:false,
        pw:false,
        pwCheck:false,
        nickName:false,
        email:false,
        contact:false,
        birth:false,
        addr:false,
        ok:function(){
            return this.id && this.pw && this.pwCheck && this.nickName
             && this.email && this.contact && this.birth && this.addr;
        },
    };

    // $("[name=memberId]").on("input",function(){
        $("[name=memberId]").blur(function(e){
        var idRegex = /^[a-z][a-z0-9]{4,19}$/;
        var isValid = idRegex.test($(e.target).val());

        if(isValid){ //형식이 유효하다면
            $.ajax({
                url:"http://localhost:9999/rest/member/idCheck",
                method:"post",
                // data : {memberId : e.target.value}, //JS
                data:{memberId: $(e.target).val()}, //jQuery
                success:function(response){
                    $(e.target).removeClass("success fail fail2");
                    if(response == "Y"){ //사용가능
                        $(e.target).addClass("success");
                        status.memberId = true;
                    }
                    else{ //사용불가(중복)
                        $(e.target).addClass("fail2");
                        status.memberId = false;
                    }
                },
                error:function(){
                    alert("서버와의 통신이 원활하지 않습니다");
                },
        });
    }
        else {//형식이 유효하지 않다면(1차실패)
            $(e.target).removeClass("success fail fail2");
            $(e.target).addClass("fail");
            status.memberId = false;
        }
    });
    $("[name=memberPw]").blur(function(){
        var pwRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
        var isValid = pwRegex.test($(this).val());
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success":"fail");
        //검사 결과를 status에 저장
        status.pw = isValid;

        //비밀번호 확인창에 강제로 blur이벤트를 발생시킨다(트리거)
        $("#password-check").blur();
    });
    $("#password-check").blur(function(){
        var originPw = $("[name=memberPw]").val();
        var checkPw =  $(this).val();

        $(this).removeClass("success fail fail2");
        if(originPw.length == 0){ //비밀번호 미입력이면
            $(this).addClass("fail2");
            status.pwCheck = false;
        }
        else if(originPw == checkPw){ //비밀번호가 일치하면
            $(this).addClass("success");
            status.pwCheck = true;
        }
        else{ //비밀번호 불일치
            $(this).addClass("fail");
            status.pwCheck = false;
        }

    });

    $("[name=memberNickname]").blur(function(e){
        var regex = /^[ㄱ-ㅎㅏ-ㅣ가-힣0-9]{2,10}$/;
        var isValid = regex.test($(e.target).val());

        if(isValid){ //형식이 유효하다면
            $.ajax({   
                url:"http://localhost:9999/rest/member/nicknameCheck",
                method:"post",
                data:{memberNickname: $(e.target).val()}, //jQuery
                success:function(response){
                    $(e.target).removeClass("success fail fail2");  
                    if(response == "Y"){ //사용가능한 닉네임
                        $(e.target).addClass("success");
                        status.memberNickname = true;
                    }
                    else{ //이미 사용중인 닉네임
                        $(e.target).addClass("fail2");
                        status.memberNickname = false;
                    }
                },
                error:function(){
                    alert("서버와의 통신이 원활하지 않습니다");
                },
        });
    }
        else {//형식이 유효하지 않다면(1차실패)
            $(e.target).removeClass("success fail fail2");  
            $(e.target).addClass("fail");
            status.memberNickname = false;
        }
    }); 
      

    $("[name=memberEmail]").blur(function(){
        var regex = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
        var email = $(this).val();
        var isValid = email.length == 0 || regex.test(email);
        //var isValid = regex.test($(this).val());

        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success":"fail");
        status.email = isValid;
    });
    $("[name=memberContact]").blur(function(){
        var regex = /^010[1-9][0-9]{7}$/;
        var contact = $(this).val();
        var isValid = contact.length == 0 || regex.test(contact);
        //var isValid = regex.test($(this).val());

        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success":"fail");
        status.contact = isValid;
    });
    $("[name=memberBirth]").blur(function(){
        var regex = /^(19[0-9]{2}|20[0-9]{2})-(0[1-9]|1[0-2])-(0[1-9]|1[0-9]|2[0-9]|3[01])$/;
        var isValid = $(this).val().length == 0 || regex.test($(this).val());
        //var isValid = regex.test($(this).val());

        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success":"fail");
        status.birth = isValid;
    });
    $("[name=memberPost],[name=memberAddr1],[name=memberAddr2]").blur(function(){
        //-> this 사용 불가(확실히 누군지를 알 수 없음)
    var post = $("[name=memberPost]").val();
    var addr1 = $("[name=memberAddr1]").val();
    var addr2 = $("[name=memberAddr2]").val();

    var isBlank = post.length == 0 && addr1.length == 0 && addr2.length == 0;
    var isFill = post.length > 0 && addr1.length > 0 && addr2.length > 0;
    var isValid = isBlank || isFill;

    $("[name=memberPost],[name=memberAddr1],[name=memberAddr2]").removeClass("success fail");
    // $("[name=memberAddr1]").removeClass("success fail");
    // $("[name=memberAddr2]").removeClass("success fail");

    $("[name=memberPost],[name=memberAddr1],[name=memberAddr2]").addClass(isValid ? "success":"fail");
    // $("[name=memberAddr1]").addClass(isValid ? "success":"fail");
    // $("[name=memberAddr2]").addClass(isValid ? "success":"fail");

    status.addr = isValid;
});
            //페이지 이탈 방지
            //- window에 beforeunload 이벤트 설정
            $(window).on("beforeunload", function(){
                return false;
            });

            //- form 전송할 때는 beforeunload 이벤트를 제거
            $(".join-form").submit(function(e){
                $(".form-input").blur();
                console.table(status);
                console.log(status.ok());
                if(!status.ok()){
                    e.preventDefault();
                }
            else{
                $(window).off("beforeunload");
            }
    });
});