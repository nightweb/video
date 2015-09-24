(function($){
  console.log("okkoo")
  $(document).ready(function(){
    
    $('.read-more').click(function(){
      if($(this).hasClass('less'))
      {
        $(this).parent().find('.hidden-text').css('overflow', 'hidden');  
        $(this).removeClass('less');
        $(this).text("Read More");
      }else
      {
        $(this).parent().find('.hidden-text').css('overflow', 'visible');
        $(this).addClass('less'); 
        $(this).text("Read Less") ;
      }
      
    })
    
    $(document).on("ajax:success", ".vote_like, .vote_dislike", function(e, data, status, xhr){
      if(data.message)
      {
        console.log(data.path)
        location.href = data.path
      }else{
        var liked = (data.liked? data.liked : 0);
        var disliked = (data.disliked ? data.disliked : 0);
        $('#liked_number').text(liked);
        $('#disliked_number').text(disliked);
      }
    })
  });
  
  
})(jQuery)