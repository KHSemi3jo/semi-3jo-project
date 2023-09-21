<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
	$(function() {
		$(".reply-insert-form").submit(function(e) {
			e.preventDefault();	
			$.ajax({				
				url : "/rest/reply/add",
				method : "post",
				data : $(e.target).serialize(),
				success : function(response) {
					$("[name=replyContent]").val("");
					loadList();
				}
			});
		});
		reloadList();
		function reloadList() {	
			var params = new URLSearchParams(location.search);
			var no = params.get("shopAfterNo");
			var memberId = "${sessionScope.name}";
			$.ajax({
						url : "/rest/reply/list",
						method : "post",
						data : {
							replyOrigin : no
						},
						success : function(response) {
							$(".reply-list").empty();
							for (var i = 0; i < response.length; i++) {
								var reply = response[i];
								var template = $("#reply-template").html();
								var htmlTemplate = $.parseHTML(template);

								$(htmlTemplate).find(".replyWriter").text(
										reply.replyWriter || "탈퇴한 사용자");
								$(htmlTemplate).find(".replyContent").text(
										reply.replyContent);
								$(htmlTemplate).find(".replyTime").text(
										reply.replyTime);

								if (memberId.length = 0 || memberId != reply.replyWriter) {
		
									$(htmlTemplate).find(".w-25").empty();
								}

								$(htmlTemplate).find(".btn-delete").attr(
										"data-reply-no", reply.replyNo);
								$(htmlTemplate).find(".btn-delete").click(
										function(e) {
											var replyNo = $(this).attr(
													"data-reply-no");
											$.ajax({
												url : "/rest/reply/delete",
												method : "post",
												data : {
													replyNo : replyNo
												},
												success : function(response) {
													reloadList();
												}
											});
										});
	
								$(htmlTemplate)
										.find(".btn-edit")
										.attr("data-reply-no", reply.replyNo)
										.click(
												function() {
													var editTemplate = $(
															"#reply-edit-template")
															.html();
													var editHtmlTemplate = $
															.parseHTML(editTemplate);
			
													var replyNo = $(this).attr(
															"data-reply-no");
													var replyContent = $(this)
															.parents(
																	".view-container")
															.find(
																	".replyContent")
															.text();
													$(editHtmlTemplate).find(
															"[name=replyNo]")
															.val(replyNo);
													$(editHtmlTemplate)
															.find(
																	"[name=replyContent]")
															.val(replyContent);

							
													$(editHtmlTemplate)
															.find(".btn-cancel")
															.click(
																	function() {
											
																		$(this)
																				.parents(
																						".edit-container")
																				.prev(
																						".view-container")
																				.show();
																		$(this)
																				.parents(
																						".edit-container")
																				.remove();

																	})

								
													$(editHtmlTemplate)
															.submit(
																	function(e) {
																	
																		e
																				.preventDefault();

																		$
																				.ajax({
																					url : "/rest/reply/edit",
																					method : "post",
																	
																					data : $(
																							e.target)
																							.serialize(),
																					success : function(
																							response) {
																						reloadList();
																					}
																				});
																	});

										
													$(this)
															.parents(
																	".view-container")
															.hide()
															.after(
																	editHtmlTemplate);

												});
								$(".reply-list").append(htmlTemplate);
							}
						},
					});
		}
	});
</script>
<c:if test="${sessionScope.name != null}">
	<script>

		$(function() {
			var params = new URLSearchParams(location.search);
			var boardNo = params.get("board_no");

			$.ajax({
				url : "/rest/like/check",
				method : "post",
				data : {
					boardNo : boardNo
				},
				success : function(response) {
					
					if (response.check) {
						$(".fa-heart").removeClass("fa-solid fa-regular")
								.addClass("fa-solid");
					} else {
						$(".fa-heart").removeClass("fa-solid fa-regular")
								.addClass("fa-regular");
					}		
					$(".fa-heart").next("span").text(response.count);
				}
			});
		
			$(".fa-heart").click(
					function() {
						$.ajax({
							url : "/rest/like/action",
							method : "post",
							data : {
								boardNo : boardNo
							},
							success : function(response) {
								if (response.check) {
									$(".fa-heart").removeClass(
											"fa-solid fa-regular").addClass(
											"fa-solid");
								} else {
									$(".fa-heart").removeClass(
											"fa-solid fa-regular").addClass(
											"fa-regular");
								}
							
								$(".fa-heart").next("span")
										.text(response.count);
							}
						});
					});
		});
	</script>
</c:if>


<script id="reply-template" type="text/template">

	<div class="row flex-container view-container">
		<div class="w-75">
			<div class="row left">
				<h5 class="replyWriter">작성자</h5>
			</div>
			<div class="row left">
				<pre class="replyContent">내용</pre>
			</div>
			<div class="row left">
				<span class="replyTime">yyyy-MM-dd HH:mm:ss</span>
			</div>
		</div>
		<div class="w-25">
			<div class="row left">
				<button class="btn  btn-edit">
					<i class="fa-solid fa-edit"></i>수정
				</button>
			</div>
			<div class="row left ">
				<button class="btn btn-negative btn-delete">
					<i class="fa-solid fa-trash"></i>삭제
				</button>
			</div>
		</div>
	</div>
<hr>
</script>

<script id="reply-edit-template" type="text/template">
<form class="reply-edit-form edit-container">
<input type="hidden" name="replyNo" value="??">
	<div class="row flex-container">
		<div class="w-75">
			<textarea name="replyContent" class="form-input w-100" rows="4"></textarea>
		</div>

		<div class="w-25">
			<div class="row">
				<button class=" row btn btn-positive" type="submit">전송</button>
			</div>
			<div class="row">
				<button class=" row btn btn-negative btn-cancel" type="button">취소</button>
			</div>

		</div>
	</div>
</form>
</script>

<style>
table {
	border: 1px solid black;
	margin-left: auto;
	margin-right: auto;
}

th {
	border: 1px solid black;
	text-align: center;
}

td {
	border: 1px solid black;
	text-align: center;
}
</style>





<button class="btn btn-navy">
	<a href="/shopafter/list">쇼핑후기 목록</a>
</button>
<br>
<button class="btn btn-navy">
	<a href="/shopafter/fix?shopAfterNo=${shopAfterDto.shopAfterNo}">쇼핑후기
		수정</a>
</button>
<button class="btn btn-navy"><a href="delete?shopAfterNo=${shopAfterDto.shopAfterNo}">삭제</a>
</button>



<div class="container w-600">
	<div class="row">
		<h1>쇼핑후기 상세</h1>
	</div>
	<table >
		<tr>
			<th>쇼핑후기 번호</th>
			<th>쇼핑후기 제목</th>
			<th>쇼핑후기 내용</th>
		</tr>	
	<tr>
	<td>${shopAfterDto.shopAfterNo}</td>
	<td>${shopAfterDto.shopAfterName}</td>
	<td>${shopAfterDto.shopAfterContent}</td>
	</tr>
	</table>
</div>



<div class="row left">
	<h1>댓글 목록</h1>
</div>
<div class="reply-list row">
<form method="post" class="reply-insert-form">
	<input type="hidden" name="replyOrigin"
		value="${shopAfterDto.shopAfterNo}">
	<div class="row">
		<textarea class="form-input w-100" name="replyContent" rows="4"></textarea>
	</div>
	<div class="row">
		<button class="btn btn-navy w-100" type="submit">
			<i class="fa-solid fa-pen"></i>댓글 등록
		</button>
	</div>
</form>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>