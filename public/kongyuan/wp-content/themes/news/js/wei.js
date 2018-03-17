$(document).ready(function(){
		$('.list').each(function(index){
			$('.list').mouseover(function(){
				$(this).find('.mask').show();
			});
			$('.list').mouseout(function(){
				$('.mask').hide();
			})
		});
		/*$('#ul li').each(function(){
			$(this).hover(function(){
				$(this).find('div').css('width','100px');
			},function(){
				$(this).find('div').css('width','0px');
			})
		})*/
	});