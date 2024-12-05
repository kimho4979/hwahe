

var Insert = function(url,GUBN){	
		
			var frm = document['frm_ssq'];
			$(frm).append("<input type='hidden' name='GUBN' value="+GUBN+">");
			$.ajax({
		    type : "POST",
		    url : url,
		    data : $(frm).serialize(),
		    dataType : '',   	           
		    success : function(res){	
		    	alert('성공적으로 등록되었습니다.');
		    	location.reload();
		    }
		});
}

function nvl(val,ret) {
    if(arguments.length == 1)
        return (val == null ||val == 'null' || val == ""||val=='undefined'||val==undefined) ? "" : val;
    else
        return (val == null ||val == 'null' || val == ""||val=='undefined'||val==undefined) ? ret : val;
}

var fnObj = {
		  pageStart: function(){
		    	
		    	grid_ajax();
		    	grid_ajax2();
		    	$('#sub_top_menu a span').removeClass('a_purple');
				$('#sub_top_menu a span').eq($('#sub_top_menu a span').index()).addClass('a_purple');
				
			$("#REG_DATE").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d",
				onchange:function(){
					//toast.push(Object.toJSON(this));
				}});
			 myGrid.setConfig({
	             targetID : "AXGridTarget",
	             theme : "AXGrid",
	             fixedColSeq : '',
	             fitToWidth:true,  
	             
	             colGroup : [
	                 {
	                     key:"no", label:"checkbox", width:"30", align:"center", formatter:"checkbox", 
	                     disabled:function(){
	                         return false;
	                         return (this.index % 2 != 0);
	                     },
	                     
	                     checked:function(){
	                         return false;
	                       
	                         return (this.index % 2 == 0);
	                     }
	                 },
	                 {key:"REG_DATE", label:"출하예정일자", width:"100", align:"center", pk:true},                 
	                 //{key:"GUBN", label:"출하구분코드", width:"90", align:"center", display:false},    	                 
	                 {key:"MARKET_NAME", label:"출하예정지역", width:"130", align:"center" },    
	                 {key:"GOOD_NAME", label:"품종", width:"100", align:"center"},                  
	                 {key:"QTY", label:"예정출하량", width:"90", align:"right", formatter:"money"},
	                 {key:"GUBN_NAME", label:"출하구분", width:"120", align:"center"},
	              //   {key:"CMP_CD", label:"공판장코드", width:"80", display:false},
	                 {key:"CHUL_NO", label:"공판장코드", width:"80", display:false},
	                 {key:"BIGO", label:"출하내용", width:"400", display:false},    	                     	                    	                     	                 
	             ],
	             colHeadAlign:"center",
	            
	             body : {
	               /*  onclick: function(){  
	                	
	                	  app.modal.open({
	                          url:"/maa01/shipmntPrearngeVolm_popup.do",
	                          pars:"REG_DATE=" + this.item.REG_DATE+"&CHUL_NO="+this.item.CHUL_NO+"&QTY="+this.item.QTY
	                          +"&MARKET_CD="+this.item.CMP_CD+"&GOOD_NAME="+this.item.GOOD_NAME+"&BIGO="+this.item.BIGO	                                   
	                      }); 
	                	    	                	
	                 },*/
	                 ondblclick: function(){
	                    
	                 },
	                
	                 oncheck: function(){
	                         	                     
	                 }
	             },
	   	            
	         }); 
	 
	
	 
	 myGrid2.setConfig({
         targetID : "AXGridTarget2",
         theme : "AXGrid",
         fixedColSeq : '',
         fitToWidth:true,    	             
         colGroup : [
             {
                 key:"no", label:"checkbox", width:"30", align:"center", formatter:"checkbox", 
                 disabled:function(){
                     return false;
                     return (this.index % 2 != 0);
                 },
                 
                 checked:function(){
                     return false;
                   
                     return (this.index % 2 == 0);
                 }
             },
             {key:"REG_DATE", label:"출하일자", width:"100", align:"center", pk:true},                 
             {key:"GUBN", label:"출하구분코드", width:"90", align:"center", display:false},    	                 
             {key:"MARKET_NAME", label:"출하지역", width:"130", align:"center" },    
             {key:"GOOD_NAME", label:"품종", width:"100", align:"center"},                  
             {key:"QTY", label:"출하량", width:"90", align:"right", formatter:"money"},
             {key:"GUBN_NAME", label:"출하구분", width:"120", align:"center"},
             {key:"CMP_CD", label:"공판장코드", width:"80", display:false},         	                     	                     	                       	                 
             {key:"BIGO", label:"출하내용", width:"400", display:false},    	                     	                    	                     	                 
         ],
         colHeadAlign:"center",
                	            
     }); 

 },
 /*appendGrid: function(index){
     var item = {amount:0};
     
     if(index == "last") {
    	
    	 myGrid.appendList(item, myGrid.list.length);
     }else if(typeof index != "undefined"){
         myGrid.appendList(item, index);
     }else{
         myGrid.appendList(item);
     }
 },*/

      
  
 removeList: function(){
     var checkedList = myGrid.getCheckedList(0);// colSeq
     alert(checkedList);
     if(checkedList.length == 0){
         alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");    
         return;
     }
     if(!confirm("정말 삭제 하시겠습니까?")) return;
     
     /// something do for server
     
     var removeList = [];
     $.each(checkedList, function(){
         removeList.push({no:this.no});
     });
     myGrid.removeList(removeList); // 전달한 개체와 비교하여 일치하는 대상을 제거 합니다. 이때 고유한 값이 아닌 항목을 전달 할 때에는 에러가 발생 할 수 있습니다.
 }
			
}

jQuery(document).ready(fnObj.pageStart);  



function grid_ajax(){   		     		    	          	 
      $.ajax({
          type : 'get',
          url : "/mntr/maa11/gridList.json",
          data :  '',
          dataType : '',   	           
          success : function(res){               
              console.log(res.list);
              console.log(res.list2.pageNo2);    
              var pageCount2 =  res.list[0].TOTAL_COUNT/15;
              var pageRest = res.list[0].TOTAL_COUNT%15;
              if(pageRest ==0){
           	   pageRest=0;
              }else {
           	   pageRest=1;
              }                              
              pageCount2 = Math.floor(pageCount2);
             var pageResult = pageCount2+pageRest;
              
              var data = {
  					list: res.list,   				
  					page:{
  					//	pageNo: res.list2.pageNo2, // 현재페이지
  						pageSize:res.list[0].TOTAL_COUNT,
  				//		listCount: res.list[0].TOTAL_COUNT // 우측하단 카운트 표시 갯수
  					}
  				};
  				myGrid.setData(data);
              
            	 //myGrid.setList(res.list);
          },
      });      	    
  };
  
  function grid_ajax2(){   		     		    	          	 
      $.ajax({
          type : 'get',
          url : "/mntr/maa11/gridList2.json",
          data :  '',
          dataType : '',   	           
          success : function(res){               
              console.log(res.list);
          /*    var pageCount2 =  res.list[0].TOTAL_COUNT/15;
              var pageRest = res.list[0].TOTAL_COUNT%15;
              if(pageRest ==0){
           	   pageRest=0;
              }else {
           	   pageRest=1;
              }                              
              pageCount2 = Math.floor(pageCount2);
             var pageResult = pageCount2+pageRest;*/
              var data = {
  					list: res.list,   				
  					page:{
  					//	pageNo: res.list2.pageNo3, // 현재페이지
  						pageSize:res.list[0].TOTAL_COUNT
  					//	listCount: res.list[0].TOTAL_COUNT // 우측하단 카운트 표시 갯수
  					}
  				};
  				myGrid2.setData(data);
          },
      });      	    
  };
  



  getCheckedList= function(){
	  
	  
	  
			  var checkedList2 = myGrid2.getCheckedList(0);// colSeq //출하
			  var checkedList = myGrid.getCheckedList(0);// colSeq //출하예정
			      console.log(checkedList);
				      if(checkedList2.length == 0 && checkedList==0 ){
				          alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");    
				          return;
		     }
			     console.log(checkedList2);
			     console.log(checkedList);
			      if(!confirm("정말 삭제 하시겠습니까?")) return;
			      
			      
			      if(checkedList2.length>0 && checkedList2[0].GUBN =='2'){
				     	 var obj2=checkedList2;
				         var deleteValue = [];
				      $.each(obj2,function(key,value) {
				      	//alert('key:'+key+', REG_MONTH:'+value.REG_MONTH+',CHUL_NO2:'+value.CHUL_NO2+',MONTH_GUBN'+value.MONTH_GUBN);
				      	deleteValue +=  (value.REG_DATE+','+value.PUM_NAME+','+value.GOOD_NAME+','+value.CHUL_NO+','+value.GUBN+','+value.CMP_CD+'!');
				      });          
					      $.ajax({
					          type : 'POST',
					          url : "/mntr/maa11/deleteShipmntPrearngeVolm.json",
					          data :deleteValue,
					          dataType : '',   	           
					          success : function(res){                   	 
					         	 grid_ajax2();                	
					          },
					      });
			      }
			      
			      if(checkedList.length>0 && checkedList[0].GUBN =='1'){
			    		 var obj2=checkedList;
				         var deleteValue = [];
				        
				     $.each(obj2,function(key,value) {
				     	//alert('key:'+key+', REG_MONTH:'+value.REG_MONTH+',CHUL_NO2:'+value.CHUL_NO2+',MONTH_GUBN'+value.MONTH_GUBN);
				     	deleteValue +=  (value.REG_DATE+','+value.PUM_NAME+','+value.GOOD_NAME+','+value.CHUL_NO+','+value.GUBN+','+value.CMP_CD+'!');
				     });          
				     $.ajax({
				         type : 'POST',
				         url : "/mntr/maa11/deleteShipmntPrearngeVolm.json",
				         data :deleteValue,
				         dataType : '',   	           
				         success : function(res){                   	 
				        	 grid_ajax();                	
				         },
				     }); 
			      }
		      /*
		 alert("출하물량");
	     if(checkedList.length == 0){
	         alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");    
	         return;
	     }
	    
	     if(!confirm("정말 삭제 하시겠습니까?")) return;        	
	    	 var obj2=checkedList;
	         var deleteValue = [];
	     $.each(obj2,function(key,value) {
	     	//alert('key:'+key+', REG_MONTH:'+value.REG_MONTH+',CHUL_NO2:'+value.CHUL_NO2+',MONTH_GUBN'+value.MONTH_GUBN);
	     	deleteValue +=  (value.REG_DATE+','+value.PUM_NAME+','+value.GOOD_NAME+','+value.CHUL_NO+','+value.GUBN+','+value.CMP_CD+'!');
	     });          
	     $.ajax({
	         type : 'get',
	         url : "/mntr/maa11/deleteShipmntPrearngeVolm.json",
	         data :deleteValue,
	         dataType : '',   	           
	         success : function(res){                   	 
	        	 grid_ajax();                	
	         },
	     }); */
		      
		      
	 }
  

  $('#radio2').click(function(){
	  $('#btn_remove').remove();
	  $('#btn_remove').append("<button type='button' class='btn_remove' onclick="+getCheckedList1()+';'+">");
  });

