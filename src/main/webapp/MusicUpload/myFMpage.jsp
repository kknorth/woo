<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
	<%@ page import="java.util.ArrayList" %>
<%@page import="com.fairmusic.dto.albumDTO"%>
<%@page import="com.fairmusic.dto.audioDTO"%>
<!DOCTYPE html>
<html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="/FairMusic/MusicUpload/js/range.js"></script>
<link rel="stylesheet" href="/FairMusic/MusicUpload/css/range.css">


<title>Insert title here</title>


<script type="text/javascript">


var time;
function faketime(){
	alert("냠냠");
	time = setTimeout(fakefake,10000);
	
}

function fakefake(){
	$('#fakeloadingModal').modal('hide')
}

	$(document).ready(function() {
	
		
		
		//check if browser supports file api and filereader features
		if (window.File && window.FileReader && window.FileList && window.Blob) {
			
		   //this is not completely neccesary, just a nice function I found to make the file size format friendlier
			//http://stackoverflow.com/questions/10420352/converting-file-size-in-bytes-to-human-readable
			function humanFileSize(bytes, si) {
			    var thresh = si ? 1000 : 1024;
			    if(bytes < thresh) return bytes + ' B';
			    var units = si ? ['kB','MB','GB','TB','PB','EB','ZB','YB'] : ['KiB','MiB','GiB','TiB','PiB','EiB','ZiB','YiB'];
			    var u = -1;
			    do {
			        bytes /= thresh;
			        ++u;
			    } while(bytes >= thresh);
			    return bytes.toFixed(1)+' '+units[u];
			}


		  //this function is called when the input loads an image
			function renderImage(file){
				var reader = new FileReader();
				reader.onload = function(event){
					the_url = event.target.result
		      //of course using a template library like handlebars.js is a better solution than just inserting a string
					$('#preview').html("<img src='"+the_url+"' />")
					$('#name').html(file.name)
					$('#size').html(humanFileSize(file.size, "MB"))
					$('#type').html(file.type)
				}
		    
		    //when the file is read it triggers the onload event above.
				reader.readAsDataURL(file);
			}

		  
		  //this function is called when the input loads a video
			function renderVideo(file){
				var reader = new FileReader();
				reader.onload = function(event){
					the_url = event.target.result
		      //of course using a template library like handlebars.js is a better solution than just inserting a string
		      $('#data-vid').html("<video width='400' controls><source id='vid-source' src='"+the_url+"' type='video/mp4'></video>")
		       $('#name-vid').html(file.name)
					$('#size-vid').html(humanFileSize(file.size, "MB"))
					$('#type-vid').html(file.type)

				}
		    
		    //when the file is read it triggers the onload event above.
				reader.readAsDataURL(file);
			}

		  

		  //watch for change on the 
			$( "#the-photo-file-field" ).change(function() {
				console.log("photo file has been chosen")
				//grab the first image in the fileList
				//in this example we are only loading one file.
				console.log(this.files[0].size)
				renderImage(this.files[0])

			});
		  
			$( "#the-video-file-field" ).change(function() {
				console.log("video file has been chosen")
				//grab the first image in the fileList
				//in this example we are only loading one file.
				console.log(this.files[0].size)
				renderVideo(this.files[0])

			});

		} else {

		  alert('The File APIs are not fully supported in this browser.');

		}

		function preview(input) {
			  if (input.files && input.files[0]) {
			    var reader = new FileReader();
			    reader.onload = function (e) { $('#audio_image').attr('src', e.target.result);  }
			    reader.readAsDataURL(input.files[0]);     
			    }   
			  }
		
		$("#ccl_check").change(function() {
			  alert($("#ccl_check").val());
			  if($("#ccl_check").val()=="유료"){
				  $('#ccl_info').hide();
				  $('#copy_money').show();
				  $('#audio_price').show();
			  }else{

				  $('#copy_money').hide();
				  $('#ccl_info').show();
				  $('#audio_price').hide();
			  }
		});
		
		$("#addcopyrighter").on("click",function(){
			
						if($(".cp2").is(":visible")){
						alert("보임");
							
						}else{
							alert("안보임");
							$(".cp2").show();
							
						}
		
		});
		
		$("#audiocreate").on("click",function(){//버튼이 클릭될때 실행
			var form = $('#audioUploadForm')[0]; 
			var formData = new FormData(form); 

			$.ajax({ 
				type : 'POST',
				enctype : 'multipart/form-data',
				processData: false, 
				contentType: false, 
				cache : false,
				data: formData, 
				url: '/FairMusic/audio.do', 
				success: function(data){
					alert(data);
					
				},error : function(e) {
					console.log("ERROR : ", e);
				}
			
			});
			
		});
		
		
		$("#albumcreate").on("click",function(){//버튼이 클릭될때 실행
			$('#albumUploadForm').attr({action:'/FairMusic/album.do?state=0', method:'post'}).submit();
		});
	
		$(function() {
			  
			  $('#dropzone').on('dragover', function() {
			    $(this).addClass('hover');
			  });
			  
			  $('#dropzone').on('dragleave', function() {
			    $(this).removeClass('hover');
			  });
			  
			  $('#dropzone input').on('change', function(e) {
			    var file = this.files[0];

			    $('#dropzone').removeClass('hover');
			    
			    if (this.accept && $.inArray(file.type, this.accept.split(/, ?/)) == -1) {
			      return alert('File type not allowed.');
			    }
			    
			    $('#dropzone').addClass('dropped');
			    $('#dropzone img').remove();
			    
			    if ((/^image\/(gif|png|jpeg)$/i).test(file.type)) {
			      var reader = new FileReader(file);

			      reader.readAsDataURL(file);
			      
			      reader.onload = function(e) {
			        var data = e.target.result,
			            $img = $('<img />').attr('src', data).fadeIn();
			        
			        $('#dropzone div').html($img);
			      };
			    } else {
			      var ext = file.name.split('.').pop();
			      
			      $('#dropzone div').html(ext);
			    }
			  });
			});
		/* 
		alert("도큐먼트 대기중");
		$("#uploadagreechk").on("click",function(){
		  $("#agreeModal").modal("hide"); 
		  $("#selectModal").modal({show: true})
		
		   alert("업로드 눌렀따");
		}); 
		
		$("#audioupload").on("click",function(){
		  $("#selectModal").modal("hide");
		  $("#audioModal").modal("show");
		});
		
		$("#albumupload").on("click",function(){
		  $("#selectModal").modal("hide");
		  $("#myModal2").modal("show");
		}); */
	});
</script>

</head>
<body>
	<div class="row">
		<div class="col-sm-3">
			<img src="/FairMusic/images/temp.png"
				class="img-circle img-responsive" alt="Placeholder image">
		</div>
		<div class="col-sm-9">
			<div class="row">
				<div class="col-sm-5">
					<span class="label label-info">해원우해원</span>
				</div>
				<div class="col-sm-4 col-sm-offset-0"></div>
				<div class="col-sm-3">
					 <button type="button" class="btn btn-info btn-lg " data-toggle="modal" data-target="#editModal">EDIT</button>
				</div>
				<div class="col-sm-12">
					<fieldset>
						<legend>자기소개</legend>
						<span class="label label-success">안녕하세요 2조의 귀염둥이를 맡고 있는
							귀염둥이 해원이에요. 잘부탁드려요!!!<br> 준희씨의 노래를 정말정말 좋아한답니다.<br>
						</span>
					</fieldset>
					&nbsp;
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-9">
			<div role="tabpanel">
				<ul class="nav nav-tabs" role="tablist">
					<li role="presentation" class="active"><a href="#home1"
						data-toggle="tab" role="tab" aria-controls="tab1">All</a></li>
					<li role="presentation"><a href="#paneTwo1" data-toggle="tab"
						role="tab" aria-controls="tab2">Music</a></li>
					<li role="presentation"><a href="#panethree" data-toggle="tab"
						role="tab" aria-controls="tab3">BlockChain Certificate</a></li>
				</ul>
				<div id="tabContent1" class="tab-content">
					<div role="tabpanel" class="tab-pane fade in active" id="home1">
						<p>
						<div class="myFMContents">
							<jsp:include page="/audiolist.do"></jsp:include>
							<%ArrayList<audioDTO> audiolist = (ArrayList<audioDTO>)request.getAttribute("myaudiolist"); %>
							<%
							System.out.println(audiolist);
							if(audiolist!=null){

								for(int i=0;i<audiolist.size();i++){
									audioDTO dto = audiolist.get(i);
									%>
									<input type = "button" value = "<%= dto.getAudio_title()%>"/>
									<%System.out.println(dto.getAudio_title());
								}
							}
							%>
						</div>
						<div class="row">
							<div class="col-sm-4">
								<button type="button" class="btn btn-info btn-lg"
									data-toggle="modal" data-target="#agreeModal">upload</button>

							</div>
							<div class="col-sm-4">
								<button type="button" class="btn btn-warning">update</button>
							</div>
							<div class="col-sm-4">
								<button type="button" class="btn btn-warning">delete</button>
							</div>
						</div>
						</p>
					</div>
					<div role="tabpanel" class="tab-pane fade" id="paneTwo1">
						<p>&nbsp;</p>
					</div>
					<div role="tabpanel" class="tab-pane fade" id="panethree">
						<a class="btn btn-info btn-lg " data-toggle="modal" data-target="#editModal">Certification</a>
							<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="my80sizeModalLabel">
							<!-- 모달  -->
								<div class="modal-dialog modal-80size" role="document">
									<div class="modal-content modal-80size">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
											<h4 class="modal-title" id="myModalLabel" align="center">BlockChain Certification</h4>
										</div>
										
										<div class="modal-body">
											<!-- <img src="images/certificate.PNG" id="bg" align="middle"> -->
											<div id="bg" class="img-thumbnail" alt="Cinque Terre" ><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
											<div class="header">fairMusic은 음원 저작권을 블록체인 상에 보관함으로써 자신들의 권리를 보호해줍니다.</div>
											<div class= "musicname" id= "musicname"></div>
											<div class= "musichash" id= "musichash"></div>
											<div class= "txid" id= "txid"></div>
											<div class= "timestamp" id= "timestamp"></div>
											<div class= "username" id= "username"></div>
											</div>	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
										</div>
										
									</div>
								</div>
							</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-3">
			<div role="tabpanel">
				<ul class="nav nav-tabs" role="tablist">
					<li role="presentation" class="active"><a href="#home2"
						data-toggle="tab" role="tab" aria-controls="tab1">팔로잉</a></li>
					<li role="presentation"><a href="#paneTwo2" data-toggle="tab"
						role="tab" aria-controls="tab2">팔로워</a></li>
					<li role="presentation" class="dropdown"></li>
				</ul>
				<div id="tabContent2" class="tab-content">
					<div role="tabpanel" class="tab-pane fade in active" id="home2">
						<p>
							<img src="/FairMusic/images/temp.png"
								class="img-circle img-responsive" alt="Placeholder image"
								width="40">
						</p>
					</div>
					<div role="tabpanel" class="tab-pane fade" id="paneTwo2">
						<p>
							<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>




	<div class="modal fade" id="agreeModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h3>UPLOAD</h3>
				</div>

				<div class="modal-body">
					<h3>파일 업로드에 동의하십니까?</h3>
					<input type="checkbox" id="uploadagreechk" data-toggle="modal"
						data-target="#selectModal" data-dismiss="modal" aria-hidden="true" />
				</div>
				<div class="modal-footer"></div>
			</div>

		</div>
	</div>

	<div class="modal fade" id="selectModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h3></h3>
				</div>

				<div class="modal-body">
					<button type="button" class="btn btn-info" id="audioupload"
						data-toggle="modal" data-target="#audioModal" data-dismiss="modal"
						aria-hidden="true">
						<h1>음원</h1>
					</button>
					<button type="button" class="btn btn-info" id="albumupload" data-toggle="modal" data-target="#albumModal" data-dismiss="modal"
						aria-hidden="true">
						<h1>앨범</h1>
					</button>
				</div>
				<div class="modal-footer"></div>
			</div>

		</div>
	</div>

	<div class="modal fade" id="audioModal" role="dialog" width = "1200">
		<div class="modal-dialog modal-lg">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-body">
					<jsp:include page="/MusicUpload/musicupload.jsp"></jsp:include>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" aria-hidden="true" id="audiocreate" data-toggle="modal" data-target="#fakeloadingModal"  onclick = "faketime()">등록하기</button>
				</div>
			</div>
		</div>
	</div>
	<form id = "albumUploadForm" enctype="multipart/form-data" method="post" name ="albumUploadForm">
	<div class="modal fade" id="albumModal" role="dialog" >
		<div class="modal-dialog modal-lg">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-body">
					<div class="row">
							<div class="col-xs-3">
								<div id="dropzone">

								<div>dropzone</div>

								<input type="file" accept="image/png, application/pdf"
									id="album_image_file" name="album_image_file" />

							</div>
							</div>
							<div class="col-xs-8">
								<div class="row">
									<div class="col-xs-2">
										<span class="label label-info">앨범 명</span>
									</div>
									<div class="col-xs-10">
										<input type="text" name="album_title" id="album_title" required="required">
									</div>
									<div class="col-xs-2">
										<span class="label label-info">앨범구매 할인가</span>
									</div>
									<div class="col-xs-10">
										<div class="range-slider">
  <input class="range-slider__range" type="range" value="0" min="0" max="10" id = "album_sale" name = "album_sale">
  <span class="range-slider__value">0</span>
</div> 
									</div>
									<div class="col-xs-2">
										<span class="label label-info">소개</span>
									</div>
									<div class="col-xs-10">
										<textarea name="album_detail" id="album_detail"></textarea>
										</div>
								</div>
							</div>
						</div>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" aria-hidden="true" id ="albumcreate">등록하기</button>
					
				</div>
			</div>

		</div>
	</div>
	</form>
	
	<div class="modal fade" id="editModal" role="dialog">
    <div class="modal-dialog modal-lg">
    
      <!-- Modal content-->
      <div class="modal-content">
         <div class = "modal-header">
         <h3>Edit your Profile</h3>
      </div>

        <div class = "modal-body">
            <div class="row">
               <div class="col-sm-3">
                  <img src="/FairMusic/images/temp.png" class="img-circle img-responsive" alt="Placeholder image">
                  <input type="file"/>
               </div>
               <div class="col-sm-9">
                  <div>
                     <h5>Display name</h5>
                     <input name="name" type="text" />
                  </div>
                  <div class="row">
                     <div class="col-sm-6">
                        <h5>First name</h5>
                        <input type="text">
                        <h5>City</h5>
                        <input type="text">
                     </div>
                     <div class="col-sm-6">
                         <h5>Last name</h5>
                        <input type="text">
                        <h5>Country</h5>
                        <input type="text">
                     </div>
                  </div>
                  <div>
                  <h5>bio</h5>
                  <textarea class="form-control" rows="5" id="comment"></textarea>
                   <h3>your links</h3>
                  <div id="linktext"><input type="text" size="70" /><br/></div>
                  <div ><input type="button" value="add link" id="addlink"/></div>                 
                  </div>
               </div>
            </div>
        </div>
        <div class="modal-footer">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">Cancel</button>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"> Save changes</button>      
        </div>
      </div>
      
    </div>
  </div>
  <div class="modal fade" id="fakeloadingModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
      	<div class = "modal-header">
			<h3>UPLOADING</h3>
		</div>

        <div class = "modal-body">
			<h3> 로딩중입니다 </h3>
			
		</div>
        <div class="modal-footer">
        	
        </div>
      </div>
      
    </div>
  </div>
</body>
</html>