$(function(){
    //전체선택과 개별체크박스에 대한 이벤트 구현

    //전체선택
    $(".check-all").change(function(){
        var check = $(this).prop("checked");
        $(".check-all, .check-item").prop("checked", check);

    });
    //개별체크박스
    $(".check-item").change(function(){
        //개별체크박스개수 == 체크된개별체크박스개수;
        // var allCheck = $(".check-item").length == $(".check-item:ckecked").length;//checked는 js명령이라..
        var allCheck = $(".check-item").length == $(".check-item").filter(":checked").length;//
        $(".check-all").prop("checked",allCheck);

    });

});