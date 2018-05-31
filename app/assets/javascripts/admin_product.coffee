# = require simditor/simditor
# = require jquery.uploadifive.min

$(document).ready ->
  $('#product_photo').uploadifive
    uploadScript: "/products/upload_photo"      
    buttonText: "选择图片"
    width: 100
    height: 100
    multi: true
    removeCompleted: true
    fileType: 'image/*'
    onUploadComplete: (file, data) ->
      rsp = JSON.parse data      
      img = '<div class="img">'
      img += '<img src="' + rsp.preview + '" width="100" height="100"/>'
      img += '<span class="remove glyphicon glyphicon-minus-sign"></span>'
      img += '<input type="hidden" name="picture_id" value="' + rsp.asset_id + '"></input>'
      img += '</div>'

      $(img).insertBefore $('.img-panel > .photo-input-container')   