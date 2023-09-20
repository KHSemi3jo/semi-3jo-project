<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

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
                    },
                });
            });
        }); 
    </script>


<form action="add" method="post" enctype="multipart/form-data" autocomplete="off">
<div class="container w-600">
	<div class="row">
		<h1> 상품 등록</h1>
	</div>
     <div class="row left">
     <label>상품이미지</label>
     	 <input type="file" class="file-chooser" name="attach" accept="image/*">
    </div>
     <div class="row left">
     <label>상품이름</label>
		 <input type="text"  class="form-input w-100" name="productName">
    </div>
    <div class="row left">
    <label>상품가격</label>
		 <input type="number"  class="form-input w-100"name="productPrice">
    </div>
    <div class="row left">
    <label>상품중량</label>
		 <input type="text" class="form-input w-100" name="productWeight">
    </div>
    <div class="row left">
    <label>원산지</label>
		 <input type="text" class="form-input w-100" name="productOrigin">
    </div>
    <div class="row left">
    <label>상품타입</label>
		 <input type="text" class="form-input w-100" name="productType">
    </div>
    <div class="row left">
        <button type="submit" class="btn btn-orange btn-save w-100">상품 등록</button>
    </div>
   </div>
	</form>






<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>