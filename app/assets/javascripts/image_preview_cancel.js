function previewCanceller() {
  $('.preview-cancel').on('click', function(){
    $("#preview-image").html("");
  });
};

$(document).on('turbolinks:load', previewCanceller);
