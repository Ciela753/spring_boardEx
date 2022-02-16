<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment-with-locales.min.js" integrity="sha512-LGXaggshOkD/at6PFNcp2V2unf9LzFq6LE+sChH7ceMTDP0g2kn6Vxwgg7wkPP7AAtX+lmPqPdxB47A0Nz0cMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<style>
	.uploadResult {
		backgrond-color : grey;
	}
	.uploadResult ul {
		displsy:flex;
		flex-flow:row;
		justify-content: center;
		align-items: center;
	}
	.uploadResult ul li {
		list-style: none;
		padding :10px;
	}
	.uploadResult ul li img{
		width: 100px;
	}
	.bigPictureWrapper {
		position: absolute;
		display: none;
		justify-content: center;
		top: 0%;
		width: 100%;
		height: 100%;
		background-color: grey;
		z-index:100;
		background-color: pink;
	}
	.bigPicture {
		position: relative;
		display:flex;
		justify-content: center;
		align-items: center;
	}
	.bigPicture img {
		width:600px;
	}
</style>
<body>
	<div class="uploadDiv">
		<input type='file' id="flies" name='uploadFile' multiple>
	</div>
	<div class="uploadResult">
		<ul>
		
		</ul>
	</div>
		<button id="uploadBtn">Upload</button>
	<div class='bigPictureWrapper'>
		<div class='bigPicture'>
		</div>
	</div>
	<Script>
		function showImage(fileCallPath) {
			//alert(fileCallPath);
			$(".bigPictureWrapper").css("display", "flex").show();
			
			$(".bigPicture").html("<img src='/display?fileName=" +encodeURI(fileCallPath)+"'>")
			.animate({width: '100%%', height:'100%'}, 1000);
		}
		
		
		$(document).ready(function() {
			$(".bigPictureWrapper").on("click", function(e){
				$(".bigPicture"),animate({width: '0%', height: '0%'}, 1000);
				setTimeout(function(){
					$('.bigPictureWrapper').hide();
				}, 1000);
			})
			
			$(".uploadResult").on("click","span", function(e){
				   
				  var targetFile = $(this).data("file");
				  var type = $(this).data("type");
				  console.log(targetFile);
				  
				  $.ajax({
				    url: '/deleteFile',
				    data: {fileName: targetFile, type:type},
				    dataType:'text',
				    type: 'POST',
				      success: function(result){
				         alert(result);
				       }
				  }); //$.ajax
				  
				});
			
			$(".bigPictureWrapper").on("click", function(e){
				$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
				setTimeout(()=> {
					$(this).hide();
				}, 1000);
			})
			
			var uploadResult = $(".uploadResult ul");
			
			function showUploadedFile(uploadResultArr){
				   
				   var str = "";
				   
				   $(uploadResultArr).each(function(i, obj){
				     
				     if(!obj.image){
				       
				       var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);
				       
				       str += "<li><div><a href='/download?fileName="+fileCallPath+"'>"+
				    		   "<img src='/resources/img/pngegg.png'>"+obj.fileName+"</a>"+
				    		   "<span data-file=\'"+fileCallPath+"\' data-type='file'>x</span></div></li>";
				     }else{
				       
				       var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
				       
				       var originPath = obj.uploadPath+ "\\"+obj.uuid +"_"+obj.fileName;
				       
				       originPath = originPath.replace(new RegExp(/\\/g),"/");
				       
				       str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\"><img src='/display?fileName="+fileCallPath+"'></a>"+
				    		   "<span data-file=\'"+fileCallPath+"\' data-type='image'>x</span></li>";
				     }
				   });
				   
				   uploadResult.append(str);
				 }
			
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxSize = 5242880;
		
			function checkExtension(fileName, fileSize) {
				if(fileSize > maxSize) {
					alert("파일 사이즈 초과")
					return false;
				}
				if(regex.test(fileName)) {
					alert("해당 종류의 파일은 업로드할 수 없습니다.");
					return false;
				}
				return true
			}
			
			var cloneObj = $(".uploadDiv").clone();
			
			$("#uploadBtn").on("click", function(e){
				var formData = new FormData();
				
				var inputFile = $("input[name='uploadFile']");
				
				var files = inputFile[0].files;
				
				console.log(files);
				
				for(var i=0; i<files.length; i++) {
					//false -> true -> false
					//true -> flase -> true
					if(!checkExtension(files[i].name, files[i].size)) {
						return false;
					}
					formData.append("uploadFile", files[i]);
				}
				
				$.ajax({
					url: '/uploadAjaxAction',
					//jquery내부적으로 스트링으로 변환하는 것을 실행하지 않는다
					processData: false,
					//글자 인코딩. 멀티파트로 전송되게끔 false로 설정해준다
					contentType:false,
					data : formData,
					type : 'POST',
					dataType:'json',
					success: function(result) {
						console.log(result);
						showUploadedFile(result);
						
						$(".uploadDiv").html(cloneObj.html())
					}
				});
			})
			
		})
	</Script>
</body>
</html>