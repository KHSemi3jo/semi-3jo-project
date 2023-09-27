<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.custom-checkbox {
    display: inline-block;
    font-size: 18px;
    position: relative;
}
.custom-checkbox > [type=radio] {
    display: none; 
    }
.custom-checkbox > span {
    display: inline-block;
    width: 1em;
    height: 1em;

    background-image: url("/images/checkbox/checkbox-empty.png");
    background-size: 100%;
    background-position: center;
    background-repeat: no-repeat;
}
.custom-checkbox > [type=radio]:checked + span {
    background-image: url("/images/checkbox/checkbox-check.png");
}
</style>

  <!-- javascript 작성 공간-->
   <script>
   $(function(){
       $(".btn-save").click(function(){
           var input =$(".file-chooser")[0];

           if(input.files.length == 0) return;
           var form = new FormData();
           form.append("attach",input.files[0]);

           $.ajax({
               url:"http://localhost:8080/Gogi",
               method:"post",
               processData:false,
               contentType:false,
               data:form,
               success:function(response){
                   $("img").attr("src", "http://localhost:8080/download?attachNo="+response.attachNo);
                   $("[name=attachNo]").val(response.attachNo);
               },
           });
       });
   }); 
    </script>


<div class="container w-600 navy">
        <div class="row pb-20 pt-30">
            <h2 >상품 등록</h2>
        </div>

        <form action="add" method="post" enctype="multipart/form-data" autocomplete="off">
            <hr class="navy">
                <div class="row flex-container pt-20">
                    <div class="row w-25 left">
                        <label>상품 이미지</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <label><input type="file" name="attach" class="w-100 file-chooser"
                            style="display:none;"accept="image/*"><img src="/images/product/no-image.png" 
                            width="300"height="300"></label>
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>상품 타입</label>
                    </div>
                    <div class="row pr-30">
                        <label class="custom-checkbox">
                            <input type="radio"  name="productType" value="냉동">
                            <span ></span> 냉동
                        </label>
                    </div>
                    <div class="row pr-30">
                        <label class="custom-checkbox">
                            <input type="radio"  name="productType" value="냉장">
                            <span ></span> 냉장
                        </label>
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>상품 이름</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="productName" class="form-input w-100">
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>상품 가격 (단위: 원)</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="number" name="productPrice" class="form-input w-100">
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>상품 중량 (단위 : g)</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="productWeight"class="form-input w-100">
                    </div>
                </div>
               
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>원산지</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="productOrigin" class="form-input w-100">
                    </div>
                </div>

                <hr class="mt-30">               
                <div class="row pt-10">
                    <button type="submit" class="btn btn-orange btn-save w-300">상품 등록</button>
                </div>

    	</form>
     </div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>






