<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>

</style>


<script>
	$(function() {
		$(".reply-insert-form").submit(function(e) {	
			e.preventDefault();
			$.ajax({	
				url : "/rest/reply/add",
				method : "post",
				data : $(e.target).serialize(),
				success : function(response) {
					console.log(response);
					$("[name=replyContent]").val("");
					reloadList();
				}
			});
		});
		reloadList();
		function reloadList() {
			var params = new URLSearchParams(location.search);
			var no = params.get("shopAfterNo");		
			var memberId = "${sessionScope.name}";
			
			var page = ${replyList};

			

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


								if (memberId.length == 0
										|| memberId != reply.replyWriter) {
				
									$(htmlTemplate).find(".w-25").empty();
								}						
								$(htmlTemplate).find(".btn-delete").attr(
										"data-reply-no", reply.replyNo).click(
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
												},
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
																		$(this).parents(
																						".edit-container").prev(
																						".view-container").show();
																		$(this).parents(
																						".edit-container").remove();});

													$(editHtmlTemplate).submit(function(e) {
																	
																		e.preventDefault();
																		$.ajax({
																					url : "/rest/reply/edit",
																					method : "post",
																					data : $(
																							e.target).serialize(),
																					success : function(response) {
																						reloadList();
																					}
																				});
																	});
													$(this).parents(".view-container")
															.hide().after(editHtmlTemplate);
												});
								$(".reply-list").append(htmlTemplate);
							}
						},
					});
		}
	});
</script>
<script id="reply-template" type="text/template">
		<div class="row flex-container view-container">
			<div class="w-75">
				<div class="row left">
					<h3 class="replyWriter">작성자</h3>
				</div>
				<div class="row left">
					<pre class="replyContent">내용</pre>
				</div>
				<div class="row left">
					<span class="replyTime">yyyy-MM-dd HH:mm:ss</span>
				</div>
			</div>
			<div class="w-25">
				<div class="row right">
					<button class="btn btn-edit btn-navy">
						<i class="fa-solid fa-edit"></i>
						수정
					</button>
				</div>
				<div class="row right">
					<button class="btn btn-orange btn-delete">
						<i class="fa-solid fa-trash"></i>
						삭제
					</button>
				</div>
			</div>
		</div>
</script>
<script id="reply-edit-template" type="text/template">
		<form class="reply-edit-form edit-container">
		<input type="hidden" name="replyNo" value="?">
		<div class="row flex-container">
			<div class="w-75">
				<textarea name="replyContent" class="form-input w-100" rows="4"></textarea>
			</div>
			<div class="w-25">
				<div class="row right">
					<button type="submit" class="btn btn-positive">
						<i class="fa-solid fa-check"></i>
						수정
					</button>
				</div>
				<div class="row right">
					<button type="button" class="btn btn-negative btn-cancel">
						<i class="fa-solid fa-xmark"></i>
						취소
					</button>
				</div>
			</div>
		</div>
		</form>
</script>

<c:if test="${sessionScope.name != null}">
	<script>
		$(function() {
			var params = new URLSearchParams(location.search);
			var shopAfterNo = params.get("shopAfterNo");

			$.ajax({
				url : "/rest/like/check",
				method : "post",
				data : {
					shopAfterNo : shopAfterNo
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
								shopAfterNo : shopAfterNo
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

<div class="container w-800">
	<div class="row">
		<h2 class="pt-30 pb-30 navy">쇼핑후기 목록</h2>
	</div>
	<div class="row">
		<table class="table table-slit">
			<tr>
				<th bgcolor="#CCD5DE">제목</th>
				<td class="left">${shopAfterDto.shopAfterName}</td>
			</tr>
			<tr>
				<th bgcolor="#CCD5DE">작성자</th>
				<td class="left">${shopAfterDto.shopAfterId}</td>
			</tr>
			<tr>
				<th bgcolor="#CCD5DE">작성일</th>
				<td class="left">${shopAfterDto.shopAfterDate}</td>
			</tr>
			<tr>
				<td colspan="2" class="left">${shopAfterDto.shopAfterContent}</td>
			</tr>

			<input type="hidden" value="${shopAfterDto.shopAfterNo}">

		</table>

		<div class="row right">
			<a href="/shopafter/list" class="btn btn-navy">목록</a> 
					<c:if test="${sessionScope.name == shopAfterDto.shopAfterId || sessionScope.level =='관리자'}">
			<a class="btn btn-navy" href="/shopafter/fix?shopAfterNo=${shopAfterDto.shopAfterNo}">수정</a>
			<a class="btn btn-navy"
				href="/shopafter/delete?shopAfterNo=${shopAfterDto.shopAfterNo}">삭제</a>
		</c:if>
		</div>
	</div>
</div>




<%-- 댓글 목록이 표시될 영역 --%>
<div class="container reply-list w-800">
</div>

<div class="row page-navigator mv-30">
	<!-- 이전 버튼 -->
	<c:if test="${!vo.first}">
		<a href="list?${vo.prevQueryString}"> <i
			class="fa-solid fa-angle-left"></i>
		</a>
	</c:if>

	<!-- 숫자 버튼 -->
	<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
		<c:choose>
			<c:when test="${vo.page == i}">
				<a class="on">${i}</a>
			</c:when>
			<c:otherwise>
				<a href="list?${vo.getQueryString(i)}">${i}</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>

	<!-- 다음 버튼 -->
	<c:if test="${!vo.last}">
		<a href="list?${vo.nextQueryString}"> <i
			class="fa-solid fa-angle-right"></i>
		</a>
	</c:if>
</div>








<%-- 댓글과 관련된 화면이 작성될 위치 --%>
<c:if test="${sessionScope.name != null}">
	<div class="container w-800">
		<form class="reply-insert-form">
			<input type="hidden" name="replyOrigin"
				value="${shopAfterDto.shopAfterNo}">

			<div class="row">
				<textarea name="replyContent" class="form-input w-100" rows="4"
			style="resize: none"></textarea>
			</div>
			<div class="row">
				<button class="btn btn-orange w-100">
					<i class="fa-solid fa-pen"></i> 댓글등록
				</button>
			</div>
		</form>
	</div>
</c:if>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>