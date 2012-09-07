// creates an animated progress bar when editing the title of the post
$(document).ready(function()
{
	$("#contentbox").keyup(function()
	{
		var box=$(this).val();
		var main = box.length *100;
		var value= (main / 70);
		var count= 70 - box.length;

		if(box.length <= 70)
		{
			$('#count').html(count);
			$('#bar').animate(
		{
			"width": value+'%',
		}, 1);
		}
		//else
		//{
			//alert(' Full ');
		//}
		return false;
	});

});