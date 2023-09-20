$(function(){
    //전체선택과 개별체크박스에 대한 이벤트 구현
    // $(".delete-btn").css("display","none");
    $(".delete-btn").hide();

    //전체선택
    $(".check-all").change(function(){
        var check = $(this).prop("checked");
        $(".check-all, .check-item").prop("checked", check);

        if(check){//하나라도 체크가 되어 있다면
            // $(".delete-btn").css("display","inline-block");//버튼표시
            // $(".delete-btn").show();//버튼표시
            // $(".delete-btn").fadeIn();//천천히 나오게
            $(".delete-btn").fadeIn("fast");//빠르게 나오게
            // $(".delete-btn").slideDown();//
        }
        else{
            // $(".delete-btn").css("display","none");//버튼표시
            // $(".delete-btn").hide();//버튼표시
            // $(".delete-btn").fadeOut();
            $(".delete-btn").fadeOut("fast");
            // $(".delete-btn").slideUp();
        }
    });
    //개별체크박스
    $(".check-item").change(function(){
        //개별체크박스개수 == 체크된개별체크박스개수;
        // var allCheck = $(".check-item").length == $(".check-item:ckecked").length;//checked는 js명령이라..
        var allCheck = $(".check-item").length == $(".check-item").filter(":checked").length;//
        $(".check-all").prop("checked",allCheck);

        if($(".check-item").filter(":checked").length>0){
            $(".delete-btn").fadeIn("fast");
        }
        else{
            $(".delete-btn").fadeOut("fast");
        }
    });

    $(".delete-form").submit(function(e){
        return confirm("정말 삭제하시겠습니까?");
    });
});