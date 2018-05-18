$(function(){
	$('#lanPos').css('top',$('.hover').offset().top);
		$('.d2').hover(function(){
			$('#lanPos').css('top',$(this).offset().top);
			},function(){
				$('#lanPos').css('top',$('.hover').offset().top);
				})
		
		$('.d2').click(function(){
				for(var i=0;i<$('.d2').size();i++){
						if(this==$('.d2').get(i)){
							$('.d2').eq(i).children('a').addClass('hover');
							}else{
								$('.d2').eq(i).children('a').removeClass('hover');
								}
					}
			})
				
	})